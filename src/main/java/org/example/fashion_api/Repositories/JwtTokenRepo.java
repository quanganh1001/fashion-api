package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.JwtToken.JwtToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface JwtTokenRepo extends JpaRepository<JwtToken,Long> {
    int countByAccount_AccountId(long accountId);

    JwtToken findByRefreshToken(@Param("refreshToken") String refreshToken);

    JwtToken findTokenByTokenAndAccount_AccountId(String token,Long accountId);

    @Query(value = "SELECT * FROM jwt_tokens WHERE account_id = :accountId ORDER BY expiration_date ASC LIMIT :limit", nativeQuery = true)
    List<JwtToken> findOldestTokensByAccountId(@Param("accountId") Long accountId, @Param("limit") long limit);
}
