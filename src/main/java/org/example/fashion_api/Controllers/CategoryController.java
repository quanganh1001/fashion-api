package org.example.fashion_api.Controllers;

import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDto;
import org.example.fashion_api.Services.CategoryService.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("category")
@PreAuthorize("hasAnyRole('MANAGER')")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping()
    public List<CategoryDto> getAllCategories() {
        return categoryService.findAll();
    }

    @PutMapping("update/{catId}")
    public CategoryDto updateCategory(@PathVariable("catId") String catId, @RequestBody CategoryDto categoryDto) {
        return categoryService.save(catId,categoryDto);
    }
}
