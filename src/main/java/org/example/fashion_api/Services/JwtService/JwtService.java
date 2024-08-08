package org.example.fashion_api.Services.JwtService;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.fashion_api.Models.AccountsAdmin.AccountAdmin;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;

import java.util.Date;


public interface JwtService {

    String generateToken(
                         AccountAdmin accountAdmin);

    boolean isTokenValid(String token, Long accountId);


    JwtTokenRes RefreshToken(HttpServletRequest req, HttpServletResponse res);

    JwtTokenRes tokenRes(AccountAdmin accountAdmin);

    String generateRefreshToken(AccountAdmin accountAdmin);

    DecodedJWT decodeToken(String token);

    String extractPhone(String token);


    Date extractExpiration(String token);


    Boolean isTokenExpiredInDatabase(String token,Long accountId);

}
