package org.example.identity.Serivces.AuthService;

import feign.FeignException;
import lombok.RequiredArgsConstructor;
import org.example.identity.Exception.BadCredentialsException;
import org.example.identity.Models.Accounts.AccountLoginDto;
import org.example.identity.Models.Accounts.AccountRes;
import org.example.identity.Models.JwtToken.JwtTokenRes;
import org.example.identity.Repositories.httpClient.FashionClient;
import org.example.identity.Serivces.JwtService.JwtService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {
    private final JwtService jwtService;
    private final FashionClient fashionClient;

    @Override
    public JwtTokenRes AdminLogin(AccountLoginDto loginRequest) throws Exception {
        AccountRes existingAccount = authenticateAccount(loginRequest, List.of("ROLE_EMPLOYEE", "ROLE_MANAGER"));

        return jwtService.tokenRes(existingAccount);

    }

    @Override
    public JwtTokenRes CustomerLogin(AccountLoginDto loginRequest) throws Exception {
        AccountRes existingAccount = authenticateAccount(loginRequest, null);

        return jwtService.tokenRes(existingAccount);

    }

    private AccountRes authenticateAccount(AccountLoginDto loginRequest, List<String> validRoles) throws Exception {
        AccountRes accountRes;
        try {
            accountRes = fashionClient.verifyLogin(loginRequest, validRoles);
        } catch (FeignException e) {
            throw new BadCredentialsException();
        }

        return accountRes;
    }

}
