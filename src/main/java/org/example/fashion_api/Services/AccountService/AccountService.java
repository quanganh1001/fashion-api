package org.example.fashion_api.Services.AccountService;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Enum.RoleEnum;
import org.example.fashion_api.Models.Accounts.*;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.springframework.http.ResponseEntity;


public interface AccountService {
    JwtTokenRes Login(AccountLoginDto user);

    ResponseEntity<?> getAllAccount(String keyword, int page, int limit);

    AccountRes getAccount(Long accountId);

    AccountRes registerAccount(AccountRegisterDto accountRegisterDto);

    void deleteAccount(Long accountId);

    ResponseEntity<AccountRes> updateAccount(Long accountId, AccountUpdateDto dto);

    void changePass(Long accountId,ChangePassDto changePassDto);

    @Transactional
    void resetPass(String email);

    @Transactional
    void Logout(String token);

    Account getAccountFromAuthentication();


    void updateRole(Long accountId, RoleEnum role);

    AccountRes getCurrentAccount();
}
