package org.example.fashion_api.Services.CategoryService;

import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;


public interface CategoryService {
    List<CategoryDto> findAll();

    CategoryDto save(String catId, CategoryDto categoryDto);

    void delete(String catId) throws IOException;

    CategoryDto findById(String catId);

    CategoryDto addCategory(CategoryDto categoryDto);

    ResponseEntity<String> updateCatBackground(MultipartFile files, String catId) throws IOException;
}
