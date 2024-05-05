package org.example.fashion_api.Services.AccountService;

import org.example.fashion_api.Models.Account.AccountLoginDto;
import org.example.fashion_api.Models.Account.AccountRegisterDto;
import org.example.fashion_api.Models.Account.AccountRes;
import org.example.fashion_api.Models.Account.AccountUpdateDto;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.springframework.http.ResponseEntity;

import java.text.ParseException;
import java.util.List;


public interface AccountService {
    JwtTokenRes Login(AccountLoginDto user) throws ParseException;

    ResponseEntity<?> getAllAccount(String keyword, int page, int limit);

    AccountRes getAccount(Long accountId);

    AccountRes registerAccount(AccountRegisterDto accountRegisterDto);

    void deleteAccount(Long accountId);

    AccountRes updateAccount(Long accountId, AccountUpdateDto dto);


}
