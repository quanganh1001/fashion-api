package org.example.fashion_api.Services.AccountService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.RandomStringUtils;
import org.example.fashion_api.Enum.RoleEnum;
import org.example.fashion_api.Exception.*;
import org.example.fashion_api.Mapper.AccountMapper;
import org.example.fashion_api.Models.AccountsAdmin.*;
import org.example.fashion_api.Models.JwtToken.JwtToken;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Models.MailTemplate;
import org.example.fashion_api.Producer.MailProducer;
import org.example.fashion_api.Repositories.AccountRepo;
import org.example.fashion_api.Repositories.JwtTokenRepo;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {

    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;
    private final AccountRepo accountRepo;
    private final AccountMapper accountMapper;
    private final BCryptPasswordEncoder passwordEncoder;
    private final MailProducer mailProducer;
    private final RedisService redisService;
    private final JwtTokenRepo jwtTokenRepo;

    @Override
    public JwtTokenRes Login(AccountLoginDto loginRequest) {
        Optional<AccountAdmin> optionalAccount = Optional.empty();
        String subject = null;


        optionalAccount = accountRepo.findByPhone(loginRequest.getUsername());

        if (optionalAccount.isPresent()) {
            subject = loginRequest.getUsername();
        }

        if (optionalAccount.isEmpty()) {
            optionalAccount = accountRepo.findByEmail(loginRequest.getUsername());
            subject = loginRequest.getUsername();
        }


        if (optionalAccount.isEmpty()) {
            throw new BadCredentialsException();
        }

        AccountAdmin existingAccountAdmin = optionalAccount.get();

        if (!passwordEncoder.matches(loginRequest.getPassword(), existingAccountAdmin.getPassword())) {
            throw new BadCredentialsException();
        }

        if (!existingAccountAdmin.getIsActivated()) {
            throw new AccountIsNotActivatedException();
        }

        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                subject, loginRequest.getPassword(),
                List.of(new SimpleGrantedAuthority(existingAccountAdmin.getRole().name()))
        );

        authenticationManager.authenticate(authenticationToken);

        SecurityContextHolder.getContext().setAuthentication(authenticationToken);

        return jwtService.tokenRes(existingAccountAdmin);
    }

    @Override
    public ResponseEntity<?> getAllAccount(String keyword, int page, int limit) {
        try {
            if (page < 0) {
                page = 0;
            }

            String keyRedis = "getAllAccount(" + keyword + "," + page + "," + limit + ") - accountAdmin";

            PageAccountRes pageAccountResRes = redisService.getRedis(keyRedis, PageAccountRes.class);

            if (pageAccountResRes == null) {
                PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("id").ascending());

                Page<AccountAdmin> accountPage = accountRepo.findAllByKeyword(keyword, pageRequest);

                List<AccountRes> accountsRes = accountMapper.accountsToListAccountRes(accountPage.getContent());

                var totalAccount = accountRepo.count();
                pageAccountResRes = PageAccountRes
                        .builder()
                        .accountsRes(accountsRes)
                        .currentPage(page + 1)
                        .totalItems(totalAccount)
                        .totalPages(accountPage.getTotalPages())
                        .build();

                redisService.saveRedis(keyRedis, pageAccountResRes);
            }


            return ResponseEntity.ok(pageAccountResRes);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @Override
    public AccountRes getAccount(Long accountId) {
        return accountMapper.accountEntityToAccountRes(accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("AccountsAdmin")));
    }

    @Override
    public AccountRes registerAccount(AccountRegisterDto accountRegisterDto) {
        if (accountRepo.existsByEmail(accountRegisterDto.getEmail())) {
            throw new AlreadyExistException("Email");
        } else if (accountRepo.existsByPhone(accountRegisterDto.getPhone())) {
            throw new AlreadyExistException("Phone");
        }

        AccountAdmin accountAdmin = new AccountAdmin();

        var newPass = RandomStringUtils.randomAlphanumeric(8).toUpperCase();

        accountAdmin.setPassword(passwordEncoder.encode(newPass));

        accountAdmin.setRole(RoleEnum.ROLE_CUSTOMER);

        accountMapper.accountRegisterDtoToAccount(accountRegisterDto, accountAdmin);

        accountRepo.save(accountAdmin);

        mailProducer.send(MailTemplate.builder()
                .to(accountRegisterDto.getEmail())
                .subject("AccountAdmin created successfully!")
                .body("Your new Password is: " + newPass)
                .build());

        // send mail to user
        MailTemplate mailTemplate = MailTemplate.builder()
                .to(accountRegisterDto.getEmail())
                .subject("AccountsAdmin has been successfully registered!")
                .body("AccountsAdmin has been successfully registered!")
                .build();

        mailProducer.send(mailTemplate);

        return accountMapper.accountEntityToAccountRes(accountAdmin);
    }


    @Override
    public void deleteAccount(Long accountId) {
        AccountAdmin accountAdmin = accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("AccountsAdmin"));
        accountRepo.delete(accountAdmin);
    }

    @Override
    @Transactional
    public ResponseEntity<AccountRes> updateAccount(AccountUpdateDto dto) {
        AccountAdmin accountAdmin = getAccountFromAuthentication();
        // check exist
        if (!Objects.equals(accountAdmin.getEmail(), dto.getEmail()) && accountRepo.existsByEmail(dto.getEmail())) {
            throw new AlreadyExistException("Email");
        } else if (!Objects.equals(accountAdmin.getPhone(), dto.getPhone()) && accountRepo.existsByPhone(dto.getPhone())) {
            throw new AlreadyExistException("Phone");
        }

        accountRepo.save(accountMapper.accountUpdateDtoToAccount(dto, accountAdmin));

        return ResponseEntity.ok(accountMapper.accountEntityToAccountRes(accountAdmin));
    }

    @Transactional
    @Override
    public void changePass(Long accountId, ChangePassDto changePassDto) {

        //check auth
        AccountAdmin accountAdmin = this.getAccountFromAuthentication();

        if (Objects.equals(accountId, accountAdmin.getId())) {
            // Get current password from database
            AccountAdmin currentAccountAdmin = accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("AccountAdmin"));

            // Check if current password is correct
            if (!passwordEncoder.matches(changePassDto.getCurrentPass(), currentAccountAdmin.getPassword())) {
                throw new BadRequestException("Current password is incorrect");
            }

            accountRepo.changePassword(accountId, passwordEncoder.encode(changePassDto.getNewPass()));


            MailTemplate mailTemplate = MailTemplate.builder()
                    .to(accountAdmin.getEmail())
                    .subject("Password changed successfully!")
                    .body("Password changed successfully!")
                    .build();
            mailProducer.send(mailTemplate);
        } else
            throw new AccessDeniedException(" Access Denied");
    }

    @Transactional
    @Override
    public void resetPass(String email) {
        System.out.println(email);
        AccountAdmin accountAdmin = accountRepo.findByEmail(email).orElseThrow(() -> new NotFoundException("Email"));

        String newPass = RandomStringUtils.randomAlphanumeric(6);

        accountRepo.changePassword(accountAdmin.getId(), passwordEncoder.encode(newPass));

        // send password to mail of user
        MailTemplate mailTemplate = MailTemplate.builder()
                .to(accountAdmin.getEmail())
                .subject("Password changed successfully!")
                .body("Your new Password is: " + newPass)
                .build();
        mailProducer.send(mailTemplate);
    }

    @Transactional
    @Override
    public void Logout(String token) {

        JwtToken jwtToken = jwtTokenRepo.findByToken(token);

        if (jwtToken != null) {
            jwtTokenRepo.delete(jwtToken);
        } else {
            throw new BadRequestException("Token not found");
        }
        SecurityContextHolder.clearContext();
    }

    @Override
    public AccountAdmin getAccountFromAuthentication() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated()) {

            String userName = authentication.getName();

            Optional<AccountAdmin> account = accountRepo.findByPhoneAndIsActivatedTrue(userName);

            if (account.isEmpty()) {
                account = accountRepo.findByPhoneAndIsActivatedTrue(userName);
                if (account.isEmpty()) {
                    throw new AccessDeniedException(" Access Denied");
                }

            }

            return account.get();

        }
        throw new AccessDeniedException(" Access Denied");
    }


    @Override
    @Transactional
    public void updateRole(Long accountId, RoleEnum role) {
        accountRepo.setRole(accountId, role.name());
        redisService.clear();
    }

    @Override
    public AccountRes getCurrentAccount() {
        AccountAdmin accountAdmin = getAccountFromAuthentication();
        return accountMapper.accountEntityToAccountRes(accountAdmin);
    }

    @Override
    @Transactional
    public Boolean activatedAccount(Long accountId) {
        AccountAdmin accountAdmin = accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("AccountsAdmin"));

        Boolean handleActivateStatus = !accountAdmin.getIsActivated();

        accountRepo.handleActivateStatus(accountId, handleActivateStatus);

        redisService.clear();

        return handleActivateStatus;
    }

    @Override
    public AccountRes createAccount(CreateAccountDto createAccountDto) {
        // check exist
        if (accountRepo.existsByEmail(createAccountDto.getEmail())) {
            throw new AlreadyExistException("Email");
        } else if (accountRepo.existsByPhone(createAccountDto.getPhone())) {
            throw new AlreadyExistException("Phone");
        }

        AccountAdmin accountAdmin = new AccountAdmin();

        var newPass = RandomStringUtils.randomAlphanumeric(8).toUpperCase();

        accountAdmin.setPassword(passwordEncoder.encode(newPass));

        accountMapper.createAccountDtoToAccount(createAccountDto, accountAdmin);

        AccountAdmin newAccountAdmin = accountRepo.save(accountAdmin);

        mailProducer.send(MailTemplate.builder()
                        .to(createAccountDto.getEmail())
                        .subject("AccountAdmin created successfully!")
                        .body("Your new Password is: " + newPass)
                .build());

        return accountMapper.accountEntityToAccountRes(newAccountAdmin);

    }

    @Override
    public List<AccountRes> getAllAccountEmployees() {
        List<AccountAdmin> accountAdmins = accountRepo.findAllByRole();
        return accountMapper.accountsToListAccountRes(accountAdmins);
    }


}
