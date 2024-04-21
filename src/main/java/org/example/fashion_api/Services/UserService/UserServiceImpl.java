package org.example.fashion_api.Services.UserService;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Account.TokenDTO;
import org.example.fashion_api.Models.Account.Account;
import org.example.fashion_api.Models.Account.UserCustomDetail;
import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Repositories.UserRepo;
import org.example.fashion_api.Services.JwtService.JwtServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final AuthenticationManager authenticationManager;

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private JwtServiceImpl jwtServiceImpl;

    @Override
    public TokenDTO Login(AccountLoginDTO loginRequest) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
        }catch (Exception e){
            throw new BadCredentialsException("Invalid username or password");
        }

        Account findByAccount = userRepo.findByUsername(loginRequest.getUsername()).orElseThrow(()->new BadCredentialsException("Invalid username or pasworld"));
        String jwtToken = jwtServiceImpl.generateToken(new HashMap<>(),new UserCustomDetail(findByAccount));
        return TokenDTO
                .builder()
                .token(jwtToken)
                .role(findByAccount.getRole().name())
                .build();
    }
}
