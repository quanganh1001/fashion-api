package org.example.fashion_api.Services.CategoryService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.Categories.Category;
import org.example.fashion_api.Models.Categories.CategoryDto;
import org.example.fashion_api.Models.Categories.CategoryRes;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;


public interface CategoryService {
    List<CategoryRes> findAll() throws JsonProcessingException;

    CategoryRes save(Long catId, CategoryDto categoryDto);

    void delete(Long id) throws IOException;

    CategoryRes findById(Long id);

    CategoryRes addCategory(CategoryDto categoryDto);

    String updateCatBackground(MultipartFile files, Long id) throws IOException;

    List<CategoryRes> childCategories(Long catParentId) throws JsonProcessingException;

    List<Category> CatDescendants(Long id, List<Category> allCategory);
}
