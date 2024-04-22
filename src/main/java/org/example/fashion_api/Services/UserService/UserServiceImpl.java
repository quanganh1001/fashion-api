package org.example.fashion_api.Services.UserService;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Account.Account;
import org.example.fashion_api.Models.Account.UserCustomDetail;
import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Models.Token.Token;
import org.example.fashion_api.Models.Token.TokenRes;
import org.example.fashion_api.Repositories.TokenRepo;
import org.example.fashion_api.Repositories.UserRepo;
import org.example.fashion_api.Services.JwtService.JwtServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final AuthenticationManager authenticationManager;

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private JwtServiceImpl jwtServiceImpl;
    @Autowired
    private TokenRepo tokenRepo;

    @Override
    public TokenRes Login(AccountLoginDTO loginRequest) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
        }catch (Exception e){
            throw new BadCredentialsException("Invalid username or password");
        }

        Account findByAccount = userRepo.findByUsername(loginRequest.getUsername()).orElseThrow(()->new BadCredentialsException("Invalid username or pasworld"));
        String jwtToken = jwtServiceImpl.generateToken(new HashMap<>(),new UserCustomDetail(findByAccount));
        String refreshToken = UUID.randomUUID().toString();
        Date refreshExpirationDate = new Date(System.currentTimeMillis() + 259200000);

        tokenRepo.save(Token.builder()
                .account(findByAccount)
                .token(jwtToken)
                .expirationDate(jwtServiceImpl.extractExpiration(jwtToken))
                .refreshToken(refreshToken)
                .refreshExpirationDate(refreshExpirationDate).build());

        return TokenRes
                .builder()
                .token(jwtToken)
                .refreshToken(refreshToken)
                .role(findByAccount.getRole().name())
                .build();
    }
}
