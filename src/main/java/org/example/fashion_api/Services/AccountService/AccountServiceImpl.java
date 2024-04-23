package org.example.fashion_api.Services.AccountService;

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
import org.springframework.stereotype.Service;

import java.util.List;

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
        if(accountRepo.existsByEmail(accountRegisterDto.getEmail())){
            throw new AlreadyExistException("Email");
        }else if(accountRepo.existsByUsername(accountRegisterDto.getUsername())){
            throw new AlreadyExistException("Username");
        }else if(accountRepo.existsByPhone(accountRegisterDto.getPhone())){
            throw new AlreadyExistException("Phone");
        }

        Account account = accountMapper.accountRegisterDtoToAccount(accountRegisterDto,new Account());
        return accountMapper.accountEntityToAccountRes(account);
    }
}
