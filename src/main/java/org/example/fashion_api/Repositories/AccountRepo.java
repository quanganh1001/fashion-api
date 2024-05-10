package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Accounts.Account;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface AccountRepo extends JpaRepository<Account, Long> {
    Optional<Account> findByUsername(String username);

    Optional<Account> findByEmail(String email);

    Optional<Account> findByPhone(String phone);

    Boolean existsByUsername(String username);

    Boolean existsByEmail(String email);

    Boolean existsByPhone(String phone);

    @Query(value = "SELECT * FROM accounts WHERE LOWER(username) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
                                            "OR LOWER(email) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
                                            "OR LOWER(phone) LIKE LOWER(CONCAT('%', :keyword, '%'))", nativeQuery = true)
    Page<Account> findAllByKeyword(@Param("keyword") String keyword, PageRequest pageable);
}
