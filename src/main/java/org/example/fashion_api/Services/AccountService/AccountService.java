package org.example.fashion_api.Services.AccountService;

import org.example.fashion_api.Models.Accounts.AccountLoginDto;
import org.example.fashion_api.Models.Accounts.AccountRegisterDto;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Models.Accounts.AccountUpdateDto;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.springframework.http.ResponseEntity;


public interface AccountService {
    JwtTokenRes Login(AccountLoginDto user);

    ResponseEntity<?> getAllAccount(String keyword, int page, int limit);

    AccountRes getAccount(Long accountId);

    AccountRes registerAccount(AccountRegisterDto accountRegisterDto);

    void deleteAccount(Long accountId);

    AccountRes updateAccount(Long accountId, AccountUpdateDto dto);


}
