package org.example.fashion_api.Controllers;

import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Models.Token.TokenRes;
import org.example.fashion_api.Services.UserService.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping()
public class AuthController {
    @Autowired
    private UserServiceImpl userService;

    @PostMapping("/login")
    public ResponseEntity<TokenRes> login(@RequestBody AccountLoginDTO loginRequest) {
        return new ResponseEntity<>(userService.Login(loginRequest), HttpStatus.OK);
    }
}
