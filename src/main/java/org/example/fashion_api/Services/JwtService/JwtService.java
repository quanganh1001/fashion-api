package org.example.fashion_api.Services.JwtService;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.Account.Account;
import org.example.fashion_api.Models.Account.AccountLoginDto;
import org.example.fashion_api.Models.UserCustomDetail;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;

import java.text.ParseException;
import java.util.Date;
import java.util.Map;


public interface JwtService {

    String generateToken(Map<String, Object> extraClaims,
                         Account account);

    boolean isTokenValid(String token, Long accountId);


    @Transactional
    JwtTokenRes RefreshToken(String refreshToken) throws ParseException;

    JwtTokenRes tokenRes(Account account) throws ParseException;


    String extractUsername(String token) throws ParseException;



    Date extractExpiration(String token) throws ParseException;


    Boolean isTokenExpired(String token,Long accountId) throws ParseException;
}
