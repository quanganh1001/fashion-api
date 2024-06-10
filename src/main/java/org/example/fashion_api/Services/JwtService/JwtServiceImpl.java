package org.example.fashion_api.Services.JwtService;


import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Exception.ExpiredJwtException;
import org.example.fashion_api.Exception.InvalidTokenException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.JwtToken.JwtToken;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Repositories.AccountRepo;
import org.example.fashion_api.Repositories.JwtTokenRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class JwtServiceImpl implements JwtService {

    private static final String SECRET_KEY = "e82c73692e6fa99b1770cfd6605bfc5b9ec3a12b362d9de5459a2612191497c4";

    private static final String issuer = "nguyenquanganh";

    @Autowired
    private JwtTokenRepo jwtTokenRepo;


    private Algorithm algorithm;
    @Autowired
    private AccountRepo accountRepo;

    @PostConstruct
    protected void init() {
        algorithm = Algorithm.HMAC256(SECRET_KEY);
    }


    @Override
    public boolean isTokenValid(String token, Long accountId) {
        JwtToken tokenRepoByTokenAndAccountId = jwtTokenRepo.findTokenByTokenAndAccount_Id(token, accountId);
        return tokenRepoByTokenAndAccountId != null;
    }


    @Override
    @Transactional
    public JwtTokenRes RefreshToken(HttpServletRequest req, HttpServletResponse res) {
        String authHeader = req.getHeader("Authorization");

        if (authHeader != null) {
            String[] headerElements = authHeader.split(" ");
            if (headerElements.length == 2 && "RefreshToken".equals(headerElements[0])) {
                String refreshToken = headerElements[1];

                JwtToken token = jwtTokenRepo.findByRefreshToken(refreshToken);
                if (token == null) {
                    throw new InvalidTokenException("Refresh token");
                } else if (token.getRefreshExpirationDate().before(new Date())) {
                    throw new ExpiredJwtException("Refresh token");
                }


                String newToken = generateToken(token.getAccount());
                String newRefreshToken = generateRefreshToken(token.getAccount());
                Date newRefreshExpirationDate = new Date(System.currentTimeMillis() + 1000L * 60 * 60 * 24 * 30);

                token.setRefreshExpirationDate(newRefreshExpirationDate);
                token.setRefreshToken(newRefreshToken);
                token.setToken(newToken);
                token.setExpirationDate(extractExpiration(newToken));

                jwtTokenRepo.save(token);
                return JwtTokenRes
                        .builder()
                        .token(newToken)
                        .refreshToken(newRefreshToken)
                        .username(token.getAccount().getUsername())
                        .role(token.getAccount().getRole().name())
                        .build();
            }
            throw new BadRequestException("Invalid credentials");
        }
        throw new BadRequestException("Invalid credentials");
    }


    @Override
    public JwtTokenRes tokenRes(Account account) {
        String jwtToken = generateToken(account);
        String refreshToken = generateRefreshToken(account);

        // Đếm số lượng token hiện có cho accountId
        long tokenCount = jwtTokenRepo.countByAccount_Id(account.getId());

        // Kiểm tra nếu số lượng token vượt quá ngưỡng
        int maxTokenCount = 2;
        if (tokenCount >= maxTokenCount) {
            // Lấy danh sách các token cũ nhất cho accountId
            List<JwtToken> oldestTokens = jwtTokenRepo.findOldestTokensByAccountId(account.getId(), tokenCount - maxTokenCount + 1);

            // Xóa các token cũ nhất cho accountId
            jwtTokenRepo.deleteAll(oldestTokens);
        }

        jwtTokenRepo.save(JwtToken.builder()
                .account(account)
                .token(jwtToken)
                .expirationDate(extractExpiration(jwtToken))
                .refreshToken(refreshToken)
                .refreshExpirationDate(extractExpiration(refreshToken)).build());

        return JwtTokenRes.builder()
                .token(jwtToken)
                .refreshToken(refreshToken)
                .username(account.getUsername())
                .role(account.getRole().name())
                .build();
    }

    @Override
    public String generateToken(Account account) {

        return JWT.create()
                .withIssuer(issuer)
                .withClaim("username", account.getUsername())
                .withClaim("role", account.getRole().name())
                .withIssuedAt(new Date(System.currentTimeMillis()))
                .withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 10 * 60))
                .sign(algorithm);
    }

    @Override
    public String generateRefreshToken(Account account) {
        return JWT.create()
                .withIssuer(issuer)
                .withClaim("username", account.getUsername())
                .withClaim("role", account.getRole().name())
                .withIssuedAt(new Date(System.currentTimeMillis()))
                .withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 7))
                .sign(algorithm);
    }

    @Override
    public DecodedJWT decodeToken(String token) {
        try {
            JWTVerifier verifier = JWT.require(algorithm).build();
            return verifier.verify(token);
        } catch (TokenExpiredException e) {
            throw new ExpiredJwtException("Token");
        }

    }

    @Override
    public String extractUsername(String token) {
        return decodeToken(token).getClaim("username").asString();
    }


    @Override
    public Date extractExpiration(String token) {
        return decodeToken(token).getExpiresAt();
    }

    @Override
    public Boolean isTokenExpiredInDatabase(String token, Long accountId) {
        JwtToken tokenRepoByTokenAndAccountId = jwtTokenRepo.findTokenByTokenAndAccount_Id(token, accountId);
        return tokenRepoByTokenAndAccountId.getExpirationDate().before(new Date());
    }


}

