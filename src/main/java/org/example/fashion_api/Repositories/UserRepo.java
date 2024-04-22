package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Account.Account;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepo extends JpaRepository<Account, Long> {
    Optional<Account> findByUsername(String username);
}
