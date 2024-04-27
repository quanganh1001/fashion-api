package org.example.fashion_api.Controllers;

import org.example.fashion_api.Models.Account.AccountLoginDto;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Services.EmailService;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping()
public class AuthController {
    @Autowired
    private AccountService accountService;
    @Autowired
    private JwtService jwtService;


    @PostMapping("/login")
    public ResponseEntity<JwtTokenRes> login(@RequestBody AccountLoginDto loginRequest) {
        return new ResponseEntity<>(accountService.Login(loginRequest), HttpStatus.OK);
    }

    @PutMapping("/refreshToken")
    public ResponseEntity<JwtTokenRes> refreshToken(@RequestParam String refreshToken) {
        return new ResponseEntity<>(jwtService.RefreshToken(refreshToken), HttpStatus.OK);
    }

}
