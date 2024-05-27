package org.example.fashion_api.Controllers;

import jakarta.validation.Valid;
import org.example.fashion_api.Mapper.AccountMapper;
import org.example.fashion_api.Models.Accounts.AccountLoginDto;
import org.example.fashion_api.Models.Accounts.AccountRegisterDto;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private AccountService accountService;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private AccountMapper accountMapper;


    @PostMapping("/login")
    public ResponseEntity<JwtTokenRes> login(@Valid @RequestBody AccountLoginDto loginRequest) {
        return new ResponseEntity<>(accountService.Login(loginRequest), HttpStatus.OK);
    }

    @DeleteMapping("/logout")
    public ResponseEntity<String> logout(String token) {
        accountService.Logout(token);
        return ResponseEntity.ok("Logout successful");
    }

    @PutMapping("/refreshToken")
    public ResponseEntity<JwtTokenRes> refreshToken( String refreshToken)  {
        return new ResponseEntity<>(jwtService.RefreshToken(refreshToken), HttpStatus.OK);
    }

    @PostMapping("/register")
    public ResponseEntity<AccountRes> registerAccount(@Valid @RequestBody AccountRegisterDto accountRegisterDto) {
        return ResponseEntity.ok(accountService.registerAccount(accountRegisterDto));
    }

    @PutMapping("/resetPass")
    public ResponseEntity<String> resetPass(String email) {
        accountService.resetPass(email);
        return ResponseEntity.ok("New password has been sent to registered email");
    }

    @GetMapping("/checkAuth")
    public ResponseEntity<AccountRes> checkAuth() {

        return ResponseEntity.ok(accountMapper.accountEntityToAccountRes(accountService.getAccountFromAuthentication()));
    }
}
