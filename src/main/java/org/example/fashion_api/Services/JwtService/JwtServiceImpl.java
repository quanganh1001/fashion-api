package org.example.fashion_api.Services.JwtService;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.BadCredentialsException;
import org.example.fashion_api.Exception.ExpiredJwtException;
import org.example.fashion_api.Models.Account.Account;
import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Models.Account.UserCustomDetail;
import org.example.fashion_api.Models.JwtToken.JwtToken;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Repositories.JwtTokenRepo;
import org.example.fashion_api.Repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.*;
import java.util.function.Function;

@Service
public class JwtServiceImpl implements JwtService {

    private static final String SECRET_KEY = "e82c73692e6fa99b1770cfd6605bfc5b9ec3a12b362d9de5459a2612191497c4";
    private final JwtTokenRepo jwtTokenRepo;
    @Autowired
    private UserRepo userRepo;


    public JwtServiceImpl(JwtTokenRepo jwtTokenRepo) {
        this.jwtTokenRepo = jwtTokenRepo;
    }


    // Trích xuất tên người dùng từ một chuỗi JWT.
    @Override
    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    // Giải quyết thông tin được trích xuất
    @Override
    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {

            final Claims claims = extractAllClaims(token);
            return claimsResolver.apply(claims);

    }

    // Tạo một JWT dựa trên thông tin người dùng
    @Override
    public String generateToken(Map<String, Object> extraClaims,
                                UserCustomDetail userCustomDetails) {
        extraClaims.put("accountId", userCustomDetails.getAccount().getAccountId());
        return Jwts
                .builder()
                .setClaims(extraClaims)
                .setSubject(String.valueOf(userCustomDetails.getAccount().getUsername()))
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 360000))
                .signWith(getSignInKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    // Kiểm tra xem một JWT có hợp lệ không
    @Override
    public boolean isTokenValid(String token, Long accountId) throws Exception {
        JwtToken tokenRepoByTokenAndAccountId = jwtTokenRepo.findTokenByTokenAndAccount_AccountId(token, accountId);
        if (tokenRepoByTokenAndAccountId == null) {
            throw new BadCredentialsException();
        } else if (extractExpiration(tokenRepoByTokenAndAccountId.getToken()).before(new Date())) {
            throw new ExpiredJwtException();
        } else return true;
    }


    // Trích xuất thời điểm hết hạn của JWT.
    @Override
    public Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    // Trích xuất tất cả các thông tin từ JWT
    @Override
    public Claims extractAllClaims(String token) {
        return Jwts
                .parserBuilder()
                .setSigningKey(getSignInKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    //  Trả về một khóa dùng để ký JWT dựa trên một chuỗi secret key.
    @Override
    public Key getSignInKey() {
        byte[] keyBytes = Decoders.BASE64.decode(SECRET_KEY);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    @Override
    @Transactional
    public JwtTokenRes RefreshToken(String refreshToken){
        JwtToken token = jwtTokenRepo.findByRefreshToken(refreshToken);
        Account account = token.getAccount();
        String jwtToken = generateToken(new HashMap<>(),new UserCustomDetail(account));
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
    public JwtTokenRes tokenRes(AccountLoginDTO loginRequest){
        Account findByAccount = userRepo.findByUsername(loginRequest.getUsername()).orElseThrow(BadCredentialsException::new);
        String jwtToken = generateToken(new HashMap<>(),new UserCustomDetail(findByAccount));
        String refreshToken = UUID.randomUUID().toString();
        Date refreshExpirationDate = new Date(System.currentTimeMillis() + 259200000);

        // Đếm số lượng token hiện có cho accountId
        long tokenCount = jwtTokenRepo.countByAccount_AccountId(findByAccount.getAccountId());

        // Kiểm tra nếu số lượng token vượt quá ngưỡng
        int maxTokenCount = 2;
        if (tokenCount >= maxTokenCount) {
            // Lấy danh sách các token cũ nhất cho accountId
            List<JwtToken> oldestTokens = jwtTokenRepo.findOldestTokensByAccountId(findByAccount.getAccountId(), tokenCount - maxTokenCount + 1);

            // Xóa các token cũ nhất cho accountId
            jwtTokenRepo.deleteAll(oldestTokens);
        }

        jwtTokenRepo.save(JwtToken.builder()
                .account(findByAccount)
                .token(jwtToken)
                .expirationDate(extractExpiration(jwtToken))
                .refreshToken(refreshToken)
                .refreshExpirationDate(refreshExpirationDate).build());

        return JwtTokenRes
                .builder()
                .token(jwtToken)
                .refreshToken(refreshToken)
                .role(findByAccount.getRole().name())
                .build();
    }
}

