package org.example.fashion_api.Services.JwtService;

import io.jsonwebtoken.Claims;
import org.example.fashion_api.Models.Account.UserCustomDetail;

import java.security.Key;
import java.util.Date;
import java.util.Map;
import java.util.function.Function;

public interface JwtService {
    // Trích xuất tên người dùng từ một chuỗi JWT.
    String extractUsername(String token);

    // Giải quyết thông tin được trích xuất
    <T> T extractClaim(String token, Function<Claims, T> claimsResolver);

    // Tạo một JWT dựa trên thông tin người dùng
    String generateToken(Map<String, Object> extraClaims,
                         UserCustomDetail userCustomDetails);

    // Kiểm tra xem một JWT có hợp lệ không
    boolean isTokenValid(String token);

    // Kiểm tra token hết hạn hay chưa
    boolean isTokenExpired(String token);

    // Trích xuất thời điểm hết hạn của JWT.
    Date extractExpiration(String token);

    // Trích xuất tất cả các thông tin từ JWT
    Claims extractAllClaims(String token);

    //  Trả về một khóa dùng để ký JWT dựa trên một chuỗi secret key.
    Key getSignInKey();
}
