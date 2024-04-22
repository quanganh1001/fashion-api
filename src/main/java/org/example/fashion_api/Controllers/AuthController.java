package org.example.fashion_api.Controllers;

import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.example.fashion_api.Services.UserService.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping()
public class AuthController {
    @Autowired
    private UserService userService;
    @Autowired
    private JwtService jwtService;

    @PostMapping("/login")
    public ResponseEntity<JwtTokenRes> login(@RequestBody AccountLoginDTO loginRequest) {
        return new ResponseEntity<>(userService.Login(loginRequest), HttpStatus.OK);
    }

    @PutMapping("/refreshToken")
    public ResponseEntity<JwtTokenRes> refreshToken(@RequestParam String refreshToken) {
        return new ResponseEntity<>(jwtService.RefreshToken(refreshToken), HttpStatus.OK);
    }
}
