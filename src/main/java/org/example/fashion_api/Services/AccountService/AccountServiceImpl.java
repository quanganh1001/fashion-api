package org.example.fashion_api.Services.AccountService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.RandomStringUtils;
import org.example.fashion_api.Enum.RoleEnum;
import org.example.fashion_api.Exception.*;
import org.example.fashion_api.Mapper.AccountMapper;
import org.example.fashion_api.Models.Accounts.*;
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
    public JwtTokenRes AdminLogin(AccountLoginDto loginRequest) {
        Account existingAccount = authenticateAccount(loginRequest, List.of("ROLE_EMPLOYEE", "ROLE_MANAGER"));
        return jwtService.tokenRes(existingAccount);
    }

    @Override
    public JwtTokenRes CustomerLogin(AccountLoginDto loginRequest) {
        Account existingAccount = authenticateAccount(loginRequest, null);
        return jwtService.tokenRes(existingAccount);
    }

    private Account authenticateAccount(AccountLoginDto loginRequest, List<String> validRoles) {
        Optional<Account> optionalAccount = accountRepo.findByPhone(loginRequest.getUsername());

        if (optionalAccount.isEmpty()) {
            optionalAccount = accountRepo.findByEmail(loginRequest.getUsername());
        }

        if (optionalAccount.isEmpty()) {
            throw new BadCredentialsException();
        }

        Account existingAccount = optionalAccount.get();

        if (validRoles != null && !validRoles.contains(existingAccount.getRole().name())) {
            throw new BadCredentialsException();
        }

        if (!passwordEncoder.matches(loginRequest.getPassword(), existingAccount.getPassword())) {
            throw new BadCredentialsException();
        }

        if (!existingAccount.getIsActivated()) {
            throw new AccountIsNotActivatedException();
        }

        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                loginRequest.getUsername(), loginRequest.getPassword(),
                List.of(new SimpleGrantedAuthority(existingAccount.getRole().name()))
        );

        authenticationManager.authenticate(authenticationToken);
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);

        return existingAccount;
    }

    @Override
    public ResponseEntity<?> getAllAccount(String keyword, int page, int limit,String role) {
        try {
            if (page < 0) {
                page = 0;
            }


            String keyRedis = "getAllAccount(" + keyword + "," + page + "," + limit + "," + role + ") - account";

            PageAccountRes pageAccountResRes = redisService.getRedis(keyRedis, PageAccountRes.class);

            if (pageAccountResRes == null) {
                PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("id").ascending());

                Page<Account> accountPage = accountRepo.findAllByKeyword(keyword,role, pageRequest);

                List<AccountRes> accountsRes = accountMapper.accountsToListAccountRes(accountPage.getContent());

                var totalAccount = accountPage.getTotalElements();
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
        return accountMapper.accountEntityToAccountRes(accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("Accounts")));
    }

    @Override
    public AccountRes registerAccount(AccountRegisterDto accountRegisterDto) {
        if (accountRepo.existsByEmail(accountRegisterDto.getEmail())) {
            throw new AlreadyExistException("Email");
        } else if (accountRepo.existsByPhone(accountRegisterDto.getPhone())) {
            throw new AlreadyExistException("Phone");
        }

        Account account = new Account();

        var newPass = RandomStringUtils.randomAlphanumeric(8).toUpperCase();

        account.setPassword(passwordEncoder.encode(newPass));

        account.setRole(RoleEnum.ROLE_CUSTOMER);

        accountMapper.accountRegisterDtoToAccount(accountRegisterDto, account);

        accountRepo.save(account);

        mailProducer.send(MailTemplate.builder()
                .to(accountRegisterDto.getEmail())
                .subject("Account created successfully!")
                .body("Your new Password is: " + newPass)
                .build());

        // send mail to user
        MailTemplate mailTemplate = MailTemplate.builder()
                .to(accountRegisterDto.getEmail())
                .subject("Accounts has been successfully registered!")
                .body("Accounts has been successfully registered!")
                .build();

        mailProducer.send(mailTemplate);

        return accountMapper.accountEntityToAccountRes(account);
    }


    @Override
    public void deleteAccount(Long accountId) {
        Account account = accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("Accounts"));
        accountRepo.delete(account);
    }

    @Override
    @Transactional
    public ResponseEntity<AccountRes> updateAccount(AccountUpdateDto dto) {
        Account account = getAccountFromAuthentication();
        // check exist
        if (!Objects.equals(account.getEmail(), dto.getEmail()) && accountRepo.existsByEmail(dto.getEmail())) {
            throw new AlreadyExistException("Email");
        } else if (!Objects.equals(account.getPhone(), dto.getPhone())) {
            throw new BadRequestException("Can not change Phone");
        }

        accountRepo.save(accountMapper.accountUpdateDtoToAccount(dto, account));

        return ResponseEntity.ok(accountMapper.accountEntityToAccountRes(account));
    }

    @Transactional
    @Override
    public void changePass(Long accountId, ChangePassDto changePassDto) {

        //check auth
        Account account = this.getAccountFromAuthentication();

        if (Objects.equals(accountId, account.getId())) {
            // Get current password from database
            Account currentAccount = accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("Account"));

            // Check if current password is correct
            if (!passwordEncoder.matches(changePassDto.getCurrentPass(), currentAccount.getPassword())) {
                throw new BadRequestException("Current password is incorrect");
            }

            accountRepo.changePassword(accountId, passwordEncoder.encode(changePassDto.getNewPass()));


            MailTemplate mailTemplate = MailTemplate.builder()
                    .to(account.getEmail())
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
        Account account = accountRepo.findByEmail(email).orElseThrow(() -> new NotFoundException("Email"));

        String newPass = RandomStringUtils.randomAlphanumeric(6);

        accountRepo.changePassword(account.getId(), passwordEncoder.encode(newPass));

        // send password to mail of user
        MailTemplate mailTemplate = MailTemplate.builder()
                .to(account.getEmail())
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
    public Account getAccountFromAuthentication() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated()) {

            String userName = authentication.getName();

            Optional<Account> account = accountRepo.findByPhoneAndIsActivatedTrue(userName);

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
        Account account = getAccountFromAuthentication();
        return accountMapper.accountEntityToAccountRes(account);
    }

    @Override
    @Transactional
    public Boolean activatedAccount(Long accountId) {
        Account account = accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("Accounts"));

        Boolean handleActivateStatus = !account.getIsActivated();

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

        Account account = new Account();

        var newPass = RandomStringUtils.randomAlphanumeric(8).toUpperCase();

        account.setPassword(passwordEncoder.encode(newPass));

        accountMapper.createAccountDtoToAccount(createAccountDto, account);

        Account newAccount = accountRepo.save(account);

        mailProducer.send(MailTemplate.builder()
                        .to(createAccountDto.getEmail())
                        .subject("Account created successfully!")
                        .body("Your new Password is: " + newPass)
                .build());

        return accountMapper.accountEntityToAccountRes(newAccount);

    }

    @Override
    public List<AccountRes> getAllAccountEmployees() {
        List<Account> accounts = accountRepo.findAllByRole();
        return accountMapper.accountsToListAccountRes(accounts);
    }


}
