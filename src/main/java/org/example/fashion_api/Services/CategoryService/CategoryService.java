package org.example.fashion_api.Services.CategoryService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;


public interface CategoryService {
    List<CategoryDto> findAll() throws JsonProcessingException;

    CategoryDto save(String catId, CategoryDto categoryDto);

    void delete(String catId) throws IOException;

    CategoryDto findById(String catId);

    CategoryDto addCategory(CategoryDto categoryDto);

    ResponseEntity<String> updateCatBackground(MultipartFile files, String catId) throws IOException;

    List<CategoryDto> childCategories(String catParentId) throws JsonProcessingException;

    List<Category> CatDescendants(String catId, List<Category> allCategory);
}
