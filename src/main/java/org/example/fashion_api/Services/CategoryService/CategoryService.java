package org.example.fashion_api.Services.CategoryService;

import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDto;
import org.example.fashion_api.Models.Category.CategoryRes;

import java.util.List;


public interface CategoryService {
    List<CategoryDto> findAll();
    CategoryRes save(String catId, CategoryDto categoryDto);
    void delete(String catId);
    Category findById(String catId);
}
