package org.example.fashion_api.Services.JwtService;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.Account.AccountLoginDto;
import org.example.fashion_api.Models.UserCustomDetail;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;

import java.util.Date;
import java.util.Map;


public interface JwtService {

    //    // Tạo một JWT dựa trên thông tin người dùng
    String generateToken(Map<String, Object> extraClaims,
                         UserCustomDetail userCustomDetails);

    //    // Kiểm tra xem một JWT có hợp lệ không
    boolean isTokenValid(String token, Long accountId);


    @Transactional
    JwtTokenRes RefreshToken(String refreshToken);

    //
    JwtTokenRes tokenRes(AccountLoginDto loginRequest);

    DecodedJWT decodeToken(String token);

    String extractUsername(String token);

    String extractRole(String token);

    Date extractExpiration(String token);


    Boolean isTokenExpired(String token,Long accountId);
}
