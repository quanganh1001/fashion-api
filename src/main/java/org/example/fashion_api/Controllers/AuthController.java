package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Mapper.AccountMapper;
import org.example.fashion_api.Models.Accounts.AccountLoginDto;
import org.example.fashion_api.Models.Accounts.AccountRegisterDto;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthController {
    private final AccountService accountService;
    private final JwtService jwtService;
    private final AccountMapper accountMapper;


    @PostMapping("/login")
    @Operation(summary = "Login", description = "This is a login API")
    public ResponseEntity<JwtTokenRes> login(@Valid @RequestBody AccountLoginDto loginRequest) {
        return new ResponseEntity<>(accountService.Login(loginRequest), HttpStatus.OK);
    }

    @DeleteMapping("/logout")
    @Operation(summary = "Logout", description = "This is a logout API")
    public ResponseEntity<String> logout(@RequestBody String token) {
        accountService.Logout(token);
        return ResponseEntity.ok("Logout successful");
    }

    @Operation(summary = "refresh token")
    @PutMapping("/refreshToken")
    public ResponseEntity<JwtTokenRes> refreshToken(HttpServletRequest req, HttpServletResponse res)  {
        return new ResponseEntity<>(jwtService.RefreshToken(req, res), HttpStatus.OK);
    }

    @Operation(summary = "register")
    @PostMapping("/register")
    public ResponseEntity<AccountRes> registerAccount(@Valid @RequestBody AccountRegisterDto accountRegisterDto) {
        return ResponseEntity.ok(accountService.registerAccount(accountRegisterDto));
    }

    @Operation(summary = "reset pass")
    @PutMapping("/resetPass")
    public ResponseEntity<String> resetPass(@RequestBody String email) {
        accountService.resetPass(email);
        return ResponseEntity.ok("New password has been sent to registered email");
    }


    @Operation(summary = "test auth")
    @GetMapping("/checkAuth")
    public ResponseEntity<AccountRes> checkAuth() {
        return ResponseEntity.ok(accountMapper.accountEntityToAccountRes(accountService.getAccountFromAuthentication()));
    }
}
