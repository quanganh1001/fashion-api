package org.example.identity.Serivces.JwtService;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.identity.Models.Accounts.AccountRes;
import org.example.identity.Models.JwtToken.JwtTokenRes;
import org.springframework.http.ResponseEntity;

import java.util.Date;


public interface JwtService {

    String generateToken(
                         AccountRes account);

    boolean isTokenValid(String token, Long accountId);


    JwtTokenRes RefreshToken(HttpServletRequest req, HttpServletResponse res);

    JwtTokenRes tokenRes(AccountRes accountRes);

    String generateRefreshToken(AccountRes account);

    DecodedJWT decodeToken(String token);


    Date extractExpiration(String token);


    Boolean isTokenExpiredInDatabase(String token,Long accountId);

    ResponseEntity<String> verifyToken(String jwt,Long id);

    void deleteToken(String token);
}
