package org.example.fashion_api.Services.AccountService;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Enum.RoleEnum;
import org.example.fashion_api.Models.Accounts.*;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.springframework.http.ResponseEntity;

import java.util.List;


public interface AccountService {
    JwtTokenRes CustomerLogin(AccountLoginDto user);

    JwtTokenRes AdminLogin(AccountLoginDto loginRequest);

    ResponseEntity<?> getAllAccount(String keyword, int page, int limit, String role);

    AccountRes getAccount(Long accountId);

    AccountRes registerAccount(AccountRegisterDto accountRegisterDto);

    void deleteAccount(Long accountId);

    ResponseEntity<AccountRes> updateAccount( AccountUpdateDto dto);

    void changePass(Long accountId,ChangePassDto changePassDto);

    @Transactional
    void resetPass(String email);

    @Transactional
    void Logout(String token);

    Account getAccountFromAuthentication();


    void updateRole(Long accountId, RoleEnum role);

    AccountRes getCurrentAccount();

    Boolean activatedAccount(Long accountId);

    AccountRes createAccount(CreateAccountDto createAccountDto);

    List<AccountRes> getAllAccountEmployees();
}
