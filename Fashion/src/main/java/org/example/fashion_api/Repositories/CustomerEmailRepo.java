package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.CustomerEmails.CustomerEmails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerEmailRepo extends JpaRepository<CustomerEmails, Long> {
    Boolean existsByEmail(String email);
}
