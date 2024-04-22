package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Token.Token;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TokenRepo extends JpaRepository<Token,Long> {
}
