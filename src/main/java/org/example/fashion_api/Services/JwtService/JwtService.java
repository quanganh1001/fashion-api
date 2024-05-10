package org.example.fashion_api.Services.JwtService;

import com.auth0.jwt.interfaces.DecodedJWT;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;

import java.util.Date;
import java.util.Map;


public interface JwtService {

    String generateToken(Map<String, Object> extraClaims,
                         Account account);

    boolean isTokenValid(String token, Long accountId);


    JwtTokenRes RefreshToken(String refreshToken);

    JwtTokenRes tokenRes(Account account);

    DecodedJWT decodeToken(String token);

    String extractUsername(String token);

    String extractRole(String token);

    Date extractExpiration(String token);


    Boolean isTokenExpiredInDatabse(String token,Long accountId);
}
