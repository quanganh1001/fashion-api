package org.example.fashion_api.Services.AccountService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Account.*;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Repositories.AccountRepo;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

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


    @Override
    public JwtTokenRes Login(AccountLoginDto loginRequest) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
        }catch (Exception e){
            throw new BadCredentialsException("Invalid username or password");
        }

        return jwtService.tokenRes(loginRequest);
    }

    @Override
    public List<AccountRes> getAllAccount(){
        return accountMapper.toDtoList(accountRepo.findAll());
    }

    @Override
    public AccountRes getAccount(Long accountId){
        return accountMapper.accountEntityToAccountRes(accountRepo.findById(accountId).orElseThrow(()->new NotFoundException("Account")));
    }

    @Override
    public AccountRes registerAccount(AccountRegisterDto accountRegisterDto){
        if(accountRepo.existsByUsername(accountRegisterDto.getUsername())){
            throw new AlreadyExistException("Username");
        }else if(accountRepo.existsByEmail(accountRegisterDto.getEmail())){
            throw new AlreadyExistException("Email");
        }else if(accountRepo.existsByPhone(accountRegisterDto.getPhone())){
            throw new AlreadyExistException("Phone");
        }

        accountRegisterDto.setPassword(passwordEncoder.encode(accountRegisterDto.getPassword()));

        Account account = accountMapper.accountRegisterDtoToAccount(accountRegisterDto,new Account());
        accountRepo.save(account);
        return accountMapper.accountEntityToAccountRes(account);
    }


    @Override
    public void deleteAccount(Long accountId){
        Account account = accountRepo.findById(accountId).orElseThrow(()->new NotFoundException("Account"));
        accountRepo.delete(account);
    }

    @Override
    @Transactional
    public AccountRes updateAccount(Long accountId, AccountUpdateDto dto){
        Account account = accountRepo.findById(accountId).orElseThrow(()->new NotFoundException("Account"));

        if(!Objects.equals(account.getEmail(), dto.getEmail()) && accountRepo.existsByEmail(dto.getEmail())){
            throw new AlreadyExistException("Email");
        }else if(!Objects.equals(account.getPhone(), dto.getPhone()) && accountRepo.existsByPhone(dto.getPhone())){
            throw new AlreadyExistException("Phone");
        }

        accountRepo.save(accountMapper.accountUpdateDtoToAccount(dto,account));

        return accountMapper.accountEntityToAccountRes(account);
    }
}
