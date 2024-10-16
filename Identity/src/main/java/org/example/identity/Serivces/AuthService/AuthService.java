package org.example.identity.Serivces.AuthService;

import org.example.identity.Models.Accounts.AccountLoginDto;
import org.example.identity.Models.JwtToken.JwtTokenRes;

public interface AuthService {
    JwtTokenRes AdminLogin(AccountLoginDto loginRequest);

    JwtTokenRes CustomerLogin(AccountLoginDto loginRequest);
}
