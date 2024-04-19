package org.example.fashion_api.Controllers;

import org.example.fashion_api.Models.User.TokenDTO;
import org.example.fashion_api.Models.User.User;
import org.example.fashion_api.Models.User.UserLoginDTO;
import org.example.fashion_api.Services.UserService.UserService;
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
    private UserService userService;

    @PostMapping("/login")
    public ResponseEntity<TokenDTO> login(@RequestBody UserLoginDTO loginRequest) {
        return new ResponseEntity<>(userService.Login(loginRequest), HttpStatus.OK);
    }
}
