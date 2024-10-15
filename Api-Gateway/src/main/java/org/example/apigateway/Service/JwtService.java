package org.example.apigateway.Service;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.annotation.PostConstruct;

import lombok.RequiredArgsConstructor;
import org.example.apigateway.Exception.ExpiredJwtException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class JwtService{

    @Value("${secret.key}")
    private String secretKey;

    @Value("${jwt.issuer}")
    private String issuerValue;

    private static String SECRET_KEY;

    private static String issuer;

    private Algorithm algorithm;


    @PostConstruct
    protected void init() {
        SECRET_KEY = secretKey;
        issuer = issuerValue;
        algorithm = Algorithm.HMAC256(SECRET_KEY);
    }


    public DecodedJWT decodeToken(String token) {
        try {
            JWTVerifier verifier = JWT.require(algorithm).build();
            return verifier.verify(token);
        } catch (TokenExpiredException e) {
            throw new ExpiredJwtException("Token");
        }

    }

    public String extractPhone(String token) {
        return decodeToken(token).getClaim("phone").asString();
    }

}

