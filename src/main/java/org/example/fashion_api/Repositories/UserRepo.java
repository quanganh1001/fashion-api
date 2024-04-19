package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.User.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Integer> {

}
