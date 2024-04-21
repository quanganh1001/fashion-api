package org.example.fashion_api.Services.UserService;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Account.TokenDTO;
import org.example.fashion_api.Models.Account.Account;
import org.example.fashion_api.Models.Account.UserCustomDetail;
import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Repositories.UserRepo;
import org.example.fashion_api.Services.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final AuthenticationManager authenticationManager;

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private JwtService jwtService;

    @Override
    public TokenDTO Login(AccountLoginDTO loginRequest) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
        Optional<Account> findByAccount = userRepo.findByUsername(loginRequest.getUsername());
        String jwtToken = jwtService.generateToken(new HashMap<>(),new UserCustomDetail(findByAccount.get()));
        return TokenDTO
                .builder()
                .token(jwtToken)
                .role(findByAccount.get().getRole().name())
                .build();
    }
}
