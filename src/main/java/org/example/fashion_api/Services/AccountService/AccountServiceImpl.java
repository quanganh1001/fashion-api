package org.example.fashion_api.Services.AccountService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.apache.catalina.User;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.BadCredentialsException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Account.*;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Repositories.AccountRepo;
import org.example.fashion_api.Services.EmailService;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {

    private final AuthenticationManager authenticationManager;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private AccountRepo accountRepo;
    @Autowired
    private AccountMapper accountMapper;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    @Autowired
    private EmailService emailService;
    @Autowired
    private RedisService redisService;

    @Override
    public JwtTokenRes Login(AccountLoginDto loginRequest) {
        Optional<Account> optionalAccount = Optional.empty();
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

        Account existingAccount = optionalAccount.get();

        if (!passwordEncoder.matches(loginRequest.getPassword(), existingAccount.getPassword())) {
            throw new BadCredentialsException();
        }

        if (!existingAccount.getEnabled()) {
            throw new BadCredentialsException();
        }

        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                subject, loginRequest.getPassword(),
                List.of(new SimpleGrantedAuthority(existingAccount.getRole().name()))
        );

        authenticationManager.authenticate(authenticationToken);


        return jwtService.tokenRes(existingAccount);
    }

    @Override
    public ResponseEntity<?> getAllAccount(String keyword, int page, int limit) {
        try{
            String keyRedis = "getAllAccount("+keyword+","+page+","+ limit+") - account";

            AccountPageRes accountPageRes = redisService.getRedis(keyRedis,AccountPageRes.class);

            if (accountPageRes == null){
                PageRequest pageRequest = PageRequest.of(page,limit, Sort.by("account_id").ascending());

                Page<Account> accountPage = accountRepo.findAllByKeyword(keyword,pageRequest);

                List<AccountRes> accountsRes = accountMapper.accountsToListAccountRes(accountPage.getContent());

                accountPageRes = AccountPageRes
                        .builder()
                        .accountsRes(accountsRes)
                        .totalPages(accountPage.getTotalPages())
                        .build();

                redisService.saveRedis(keyRedis,accountPageRes);
            }


            return ResponseEntity.ok(accountPageRes);
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @Override
    public AccountRes getAccount(Long accountId) {
        return accountMapper.accountEntityToAccountRes(accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("Account")));
    }

    @Override
    public AccountRes registerAccount(AccountRegisterDto accountRegisterDto) {
        if (accountRepo.existsByUsername(accountRegisterDto.getUsername())) {
            throw new AlreadyExistException("Username");
        } else if (accountRepo.existsByEmail(accountRegisterDto.getEmail())) {
            throw new AlreadyExistException("Email");
        } else if (accountRepo.existsByPhone(accountRegisterDto.getPhone())) {
            throw new AlreadyExistException("Phone");
        }

        accountRegisterDto.setPassword(passwordEncoder.encode(accountRegisterDto.getPassword()));

        Account account = accountMapper.accountRegisterDtoToAccount(accountRegisterDto, new Account());
        accountRepo.save(account);

        String content = "Account has been successfully registered!";
        String subject = "Account has been successfully registered!";
        emailService.sendEmail(account.getEmail(), subject, content);

        return accountMapper.accountEntityToAccountRes(account);
    }


    @Override
    public void deleteAccount(Long accountId) {
        Account account = accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("Account"));
        accountRepo.delete(account);
    }

    @Override
    @Transactional
    public AccountRes updateAccount(Long accountId, AccountUpdateDto dto) {
        Account account = accountRepo.findById(accountId).orElseThrow(() -> new NotFoundException("Account"));

        if (!Objects.equals(account.getEmail(), dto.getEmail()) && accountRepo.existsByEmail(dto.getEmail())) {
            throw new AlreadyExistException("Email");
        } else if (!Objects.equals(account.getPhone(), dto.getPhone()) && accountRepo.existsByPhone(dto.getPhone())) {
            throw new AlreadyExistException("Phone");
        }

        accountRepo.save(accountMapper.accountUpdateDtoToAccount(dto, account));

        return accountMapper.accountEntityToAccountRes(account);
    }
}
