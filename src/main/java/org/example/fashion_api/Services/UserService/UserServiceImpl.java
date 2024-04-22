package org.example.fashion_api.Services.UserService;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final AuthenticationManager authenticationManager;
    @Autowired
    private JwtService jwtService;


    @Override
    public JwtTokenRes Login(AccountLoginDTO loginRequest) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
        }catch (Exception e){
            throw new BadCredentialsException("Invalid username or password");
        }

        return jwtService.tokenRes(loginRequest);
    }

}
