package org.example.fashion_api.Services.UserService;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.User.TokenDTO;
import org.example.fashion_api.Models.User.User;
import org.example.fashion_api.Models.User.UserCustomDetail;
import org.example.fashion_api.Models.User.UserLoginDTO;
import org.example.fashion_api.Repositories.UserRepo;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {

    private final AuthenticationManager authenticationManager;

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private JwtService jwtService;
    @Override
    public TokenDTO Login(UserLoginDTO loginRequest) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
        Optional<User> findByAccount = userRepo.findByUsername(loginRequest.getUsername());
        String jwtToken = jwtService.generateToken(new UserCustomDetail(findByAccount.get()));
        return TokenDTO
                .builder()
                .token(jwtToken)
                .role(findByAccount.get().getRole().name())
                .build();
    }
}
