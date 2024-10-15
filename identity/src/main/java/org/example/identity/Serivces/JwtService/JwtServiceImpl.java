package org.example.identity.Serivces.JwtService;


import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import feign.FeignException;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.example.identity.Exception.BadRequestException;
import org.example.identity.Exception.ExpiredJwtException;
import org.example.identity.Exception.InvalidTokenException;
import org.example.identity.Models.Accounts.AccountRes;
import org.example.identity.Models.JwtToken.JwtToken;
import org.example.identity.Models.JwtToken.JwtTokenRes;
import org.example.identity.Repositories.JwtTokenRepo;
//import org.example.identity.Repositories.httpClient.FashionClient;
import org.example.identity.Repositories.httpClient.FashionClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;


import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class JwtServiceImpl implements JwtService {
    private final FashionClient fashionClient;


    @Value("${secret.key}")
    private String secretKey;

    @Value("${jwt.issuer}")
    private String issuerValue;

    private static String SECRET_KEY;

    private static String issuer;

    private final JwtTokenRepo jwtTokenRepo;

    private Algorithm algorithm;


    @PostConstruct
    protected void init() {
        SECRET_KEY = secretKey;
        issuer = issuerValue;
        algorithm = Algorithm.HMAC256(SECRET_KEY);
    }


    @Override
    public boolean isTokenValid(String token, Long accountId) {
        JwtToken tokenRepoByTokenAndAccountId = jwtTokenRepo.findTokenByTokenAndAccountId(token, accountId);
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

                AccountRes accountRes = new AccountRes();
                try {
                    accountRes = fashionClient.getCurrentAccount();
                }catch (FeignException.FeignClientException e){
                    System.out.println("Không thể kết nối đến Fashion service: " + e.getMessage());

                }


                String newToken = generateToken(accountRes);
                String newRefreshToken = generateRefreshToken(accountRes);
                Date newRefreshExpirationDate = new Date(System.currentTimeMillis() + 1000L * 60 * 60 * 24 * 30);

                token.setRefreshExpirationDate(newRefreshExpirationDate);
                token.setRefreshToken(newRefreshToken);
                token.setToken(newToken);
                token.setExpirationDate(extractExpiration(newToken));

                jwtTokenRepo.save(token);
                return JwtTokenRes.builder().token(newToken).refreshToken(newRefreshToken).account(accountRes).build();
            }
            throw new BadRequestException("Invalid credentials");
        }
        throw new BadRequestException("Invalid credentials");
    }


    @Override
    @Transactional
    public JwtTokenRes tokenRes(AccountRes accountRes) {
        String jwtToken = generateToken(accountRes);
        String refreshToken = generateRefreshToken(accountRes);

        // Đếm số lượng token hiện có cho accountId
        long tokenCount = jwtTokenRepo.countByAccountId(accountRes.getId());

        // Kiểm tra nếu số lượng token vượt quá ngưỡng
        int maxTokenCount = 2;
        if (tokenCount >= maxTokenCount) {
            // Lấy danh sách các token cũ nhất cho accountId
            List<JwtToken> oldestTokens = jwtTokenRepo.findOldestTokensByAccountId(accountRes.getId(), tokenCount - maxTokenCount + 1);

            // Xóa các token cũ nhất cho accountId
            jwtTokenRepo.deleteAll(oldestTokens);
        }

        jwtTokenRepo.save(JwtToken.builder().accountId(accountRes.getId()).token(jwtToken).expirationDate(extractExpiration(jwtToken)).refreshToken(refreshToken).refreshExpirationDate(extractExpiration(refreshToken)).build());

        return JwtTokenRes.builder().token(jwtToken).refreshToken(refreshToken).account(accountRes).build();
    }

    @Override
    public String generateToken(AccountRes account) {

        return JWT.create().withIssuer(issuer).withClaim("phone", account.getPhone()).withClaim("role", account.getRole().name()).withIssuedAt(new Date(System.currentTimeMillis())).withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 10 * 60)).sign(algorithm);
    }

    @Override
    public String generateRefreshToken(AccountRes account) {
        return JWT.create().withIssuer(issuer).withClaim("phone", account.getPhone()).withClaim("role", account.getRole().name()).withIssuedAt(new Date(System.currentTimeMillis())).withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 7)).sign(algorithm);
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
    public Date extractExpiration(String token) {
        return decodeToken(token).getExpiresAt();
    }

    @Override
    public Boolean isTokenExpiredInDatabase(String token, Long accountId) {
        JwtToken tokenRepoByTokenAndAccountId = jwtTokenRepo.findTokenByTokenAndAccountId(token, accountId);
        return tokenRepoByTokenAndAccountId.getExpirationDate().before(new Date());
    }

    @Override
    public ResponseEntity<String> verifyToken(String jwt, Long id) {
        if (isTokenValid(jwt, id)) {
            if (!isTokenExpiredInDatabase(jwt, id)) {
                return ResponseEntity.ok("ok");
            } else throw new ExpiredJwtException("Token");
        } else throw new InvalidTokenException("Token");
    }

    @Override
    @Transactional
    public void deleteToken(String token){
        JwtToken jwtToken = jwtTokenRepo.findByToken(token);
        jwtTokenRepo.delete(jwtToken);
    }

}


