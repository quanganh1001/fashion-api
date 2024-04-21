package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Category.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepo extends JpaRepository<Category,String> {
}
