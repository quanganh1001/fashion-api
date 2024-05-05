package org.example.fashion_api.Services.JwtService;


import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.annotation.PostConstruct;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.BadCredentialsException;
import org.example.fashion_api.Exception.ExpiredJwtException;
import org.example.fashion_api.Exception.InvalidTokenException;
import org.example.fashion_api.Models.Account.Account;
import org.example.fashion_api.Models.Account.AccountLoginDto;
import org.example.fashion_api.Models.UserCustomDetail;
import org.example.fashion_api.Models.JwtToken.JwtToken;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Repositories.JwtTokenRepo;
import org.example.fashion_api.Repositories.AccountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nimbusds.jwt.SignedJWT;

import java.text.ParseException;
import java.util.*;

@Service
public class JwtServiceImpl implements JwtService {

    private static final String SECRET_KEY = "e82c73692e6fa99b1770cfd6605bfc5b9ec3a12b362d9de5459a2612191497c4";

    private static final String issuer = "nguyenquanganh";

    @Autowired
    private JwtTokenRepo jwtTokenRepo;

    private Algorithm algorithm;

    @PostConstruct
    protected void init(){
        algorithm = Algorithm.HMAC256(SECRET_KEY);
    }


    @Override
    public String generateToken(Map<String, Object> extraClaims,
                                Account account) {

        return JWT.create()
                .withIssuer(issuer)
                .withClaim("username", account.getUsername())
                .withClaim("role", account.getRole().name())
                .withIssuedAt(new Date(System.currentTimeMillis()))
                .withExpiresAt(new Date(System.currentTimeMillis()+1000 * 60 * 60 * 24))
                .sign(algorithm);
    }

    @Override
    public boolean isTokenValid(String token, Long accountId) {
        JwtToken tokenRepoByTokenAndAccountId = jwtTokenRepo.findTokenByTokenAndAccount_AccountId(token, accountId);
        return tokenRepoByTokenAndAccountId != null;
    }

    @Override
    @Transactional
    public JwtTokenRes RefreshToken(String refreshToken) throws ParseException {
        JwtToken token = jwtTokenRepo.findByRefreshToken(refreshToken);
        if(token == null) {
            throw new InvalidTokenException();
        }
        else if (token.getRefreshExpirationDate().before(new Date())){
            throw new ExpiredJwtException();
        }

        Account account = token.getAccount();
        String jwtToken = generateToken(new HashMap<>(),account);
        String newRefreshToken = UUID.randomUUID().toString();
        Date newRefreshExpirationDate = new Date(System.currentTimeMillis() + 259200000);

        jwtTokenRepo.save(JwtToken.builder()
                .id(token.getId())
                .account(account)
                .token(jwtToken)
                .expirationDate(extractExpiration(jwtToken))
                .refreshToken(newRefreshToken)
                .refreshExpirationDate(newRefreshExpirationDate)
                .revoked(token.getRevoked())
                .build());

        return JwtTokenRes
                .builder()
                .token(jwtToken)
                .refreshToken(newRefreshToken)
                .role(account.getRole().name())
                .build();
    }

    @Override
    public JwtTokenRes tokenRes(Account account) throws ParseException {
        String jwtToken = generateToken(new HashMap<>(),account);
        String refreshToken = UUID.randomUUID().toString();
        Date refreshExpirationDate = new Date(System.currentTimeMillis() + 1000L * 60 * 60 * 24 * 30);

        // Đếm số lượng token hiện có cho accountId
        long tokenCount = jwtTokenRepo.countByAccount_AccountId(account.getAccountId());

        // Kiểm tra nếu số lượng token vượt quá ngưỡng
        int maxTokenCount = 2;
        if (tokenCount >= maxTokenCount) {
            // Lấy danh sách các token cũ nhất cho accountId
            List<JwtToken> oldestTokens = jwtTokenRepo.findOldestTokensByAccountId(account.getAccountId(), tokenCount - maxTokenCount + 1);

            // Xóa các token cũ nhất cho accountId
            jwtTokenRepo.deleteAll(oldestTokens);
        }

        jwtTokenRepo.save(JwtToken.builder()
                .account(account)
                .token(jwtToken)
                .expirationDate(extractExpiration(jwtToken))
                .refreshToken(refreshToken)
                .refreshExpirationDate(refreshExpirationDate).build());

        return JwtTokenRes
                .builder()
                .token(jwtToken)
                .refreshToken(refreshToken)
                .role(account.getRole().name())
                .build();
    }


    @Override
    public String extractUsername(String token) throws ParseException {
        SignedJWT signedJWT = SignedJWT.parse(token);
        return signedJWT.getJWTClaimsSet().getClaim("username").toString();
    }


    @Override
    public Date extractExpiration(String token) throws ParseException {
        SignedJWT signedJWT = SignedJWT.parse(token);
        return signedJWT.getJWTClaimsSet().getExpirationTime();
    }

    @Override
    public Boolean isTokenExpired(String token,Long accountId) throws ParseException {
        JwtToken tokenRepoByTokenAndAccountId = jwtTokenRepo.findTokenByTokenAndAccount_AccountId(token, accountId);
        return extractExpiration(tokenRepoByTokenAndAccountId.getToken()).before(new Date());
    }
}
