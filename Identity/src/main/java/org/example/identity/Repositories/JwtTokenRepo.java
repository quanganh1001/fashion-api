package org.example.identity.Repositories;

import org.example.identity.Models.JwtToken.JwtToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface JwtTokenRepo extends JpaRepository<JwtToken,Long> {
    int countByAccountId(long accountId);

    JwtToken findByRefreshToken(@Param("refreshToken") String refreshToken);

    JwtToken findTokenByTokenAndAccountId(String token, Long accountId);

    @Query(value = "SELECT * FROM jwt_tokens WHERE account_id = :accountId ORDER BY expiration_date ASC LIMIT :limit", nativeQuery = true)
    List<JwtToken> findOldestTokensByAccountId(@Param("accountId") Long accountId, @Param("limit") long limit);

    JwtToken findByToken(String token);
}
