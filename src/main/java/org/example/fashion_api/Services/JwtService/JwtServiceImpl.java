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
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Exception.ExpiredJwtException;
import org.example.fashion_api.Exception.InvalidTokenException;
import org.example.fashion_api.Mapper.AccountMapper;
import org.example.fashion_api.Models.AccountsAdmin.AccountAdmin;
import org.example.fashion_api.Models.AccountsAdmin.AccountRes;
import org.example.fashion_api.Models.JwtToken.JwtToken;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Repositories.JwtTokenRepo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class JwtServiceImpl implements JwtService {

    @Value("${secret.key}")
    private String secretKey;

    @Value("${jwt.issuer}")
    private String issuerValue;

    private static String SECRET_KEY;

    private static String issuer;

    private final JwtTokenRepo jwtTokenRepo;

    private final AccountMapper accountMapper;

    private Algorithm algorithm;


    @PostConstruct
    protected void init() {
        SECRET_KEY = secretKey;
        issuer = issuerValue;
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


                String newToken = generateToken(token.getAccountAdmin());
                String newRefreshToken = generateRefreshToken(token.getAccountAdmin());
                Date newRefreshExpirationDate = new Date(System.currentTimeMillis() + 1000L * 60 * 60 * 24 * 30);

                token.setRefreshExpirationDate(newRefreshExpirationDate);
                token.setRefreshToken(newRefreshToken);
                token.setToken(newToken);
                token.setExpirationDate(extractExpiration(newToken));

                AccountRes accountRes = accountMapper.accountEntityToAccountRes(token.getAccountAdmin());

                jwtTokenRepo.save(token);
                return JwtTokenRes
                        .builder()
                        .token(newToken)
                        .refreshToken(newRefreshToken)
                        .account(accountRes)
                        .build();
            }
            throw new BadRequestException("Invalid credentials");
        }
        throw new BadRequestException("Invalid credentials");
    }


    @Override
    public JwtTokenRes tokenRes(AccountAdmin accountAdmin) {
        String jwtToken = generateToken(accountAdmin);
        String refreshToken = generateRefreshToken(accountAdmin);

        // Đếm số lượng token hiện có cho accountId
        long tokenCount = jwtTokenRepo.countByAccount_Id(accountAdmin.getId());

        // Kiểm tra nếu số lượng token vượt quá ngưỡng
        int maxTokenCount = 2;
        if (tokenCount >= maxTokenCount) {
            // Lấy danh sách các token cũ nhất cho accountId
            List<JwtToken> oldestTokens = jwtTokenRepo.findOldestTokensByAccountId(accountAdmin.getId(), tokenCount - maxTokenCount + 1);

            // Xóa các token cũ nhất cho accountId
            jwtTokenRepo.deleteAll(oldestTokens);
        }

        jwtTokenRepo.save(JwtToken.builder()
                .accountAdmin(accountAdmin)
                .token(jwtToken)
                .expirationDate(extractExpiration(jwtToken))
                .refreshToken(refreshToken)
                .refreshExpirationDate(extractExpiration(refreshToken)).build());

        AccountRes accountRes = accountMapper.accountEntityToAccountRes(accountAdmin);

        return JwtTokenRes.builder()
                .token(jwtToken)
                .refreshToken(refreshToken)
                .account(accountRes)
                .build();
    }

    @Override
    public String generateToken(AccountAdmin accountAdmin) {

        return JWT.create()
                .withIssuer(issuer)
                .withClaim("phone", accountAdmin.getPhone())
                .withClaim("role", accountAdmin.getRole().name())
                .withIssuedAt(new Date(System.currentTimeMillis()))
                .withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 10 * 60))
                .sign(algorithm);
    }

    @Override
    public String generateRefreshToken(AccountAdmin accountAdmin) {
        return JWT.create()
                .withIssuer(issuer)
                .withClaim("phone", accountAdmin.getPhone())
                .withClaim("role", accountAdmin.getRole().name())
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
    public String extractPhone(String token) {
        return decodeToken(token).getClaim("phone").asString();
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

