package org.example.fashion_api.Repositories;

import org.example.fashion_api.Enum.RoleEnum;
import org.example.fashion_api.Models.Accounts.Account;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AccountRepo extends JpaRepository<Account, Long> {

    Optional<Account> findByEmail(String email);

    Optional<Account> findByPhone(String phone);

    Boolean existsByEmail(String email);

    Boolean existsByPhone(String phone);

    @Query(value = "SELECT * FROM accounts WHERE LOWER(name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
                                            "OR LOWER(phone) LIKE LOWER(CONCAT('%', :keyword, '%'))", nativeQuery = true)
    Page<Account> findAllByKeyword(@Param("keyword") String keyword, PageRequest pageable);

    @Modifying
    @Query(value = "UPDATE accounts SET password = :newPass WHERE id = :accountId",nativeQuery = true)
    void changePassword(@Param("accountId") Long accountId, @Param("newPass") String newPass);

    @Modifying
    @Query(value = "UPDATE accounts SET role = :role WHERE id = :accountId",nativeQuery = true)
    void setRole(@Param("accountId") Long accountId,@Param("role") String role);

    @Modifying
    @Query(value = "UPDATE accounts SET is_activated = :status WHERE id = :accountId",nativeQuery = true)
    void handleActivateStatus(@Param("accountId") Long accountId,@Param("status") Boolean status);

    @Query(value = "SELECT * FROM accounts WHERE role = 'ROLE_MANAGER' OR role = 'ROLE_EMPLOYEE'",nativeQuery = true)
    List<Account> findAllByRole();
}
