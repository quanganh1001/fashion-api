package org.example.fashion_api.Services.CategoryService;

import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDTO;

import java.util.List;

public interface CategoryService {
    List<Category> findAll();
    List<Category> save(CategoryDTO category);
    void delete(String catId);
    Category findById(String catId);
}
