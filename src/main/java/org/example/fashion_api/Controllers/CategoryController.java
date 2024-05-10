package org.example.fashion_api.Controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.validation.Valid;
import org.example.fashion_api.Models.Categories.CategoryDto;
import org.example.fashion_api.Services.CategoryService.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("categories")
@PreAuthorize("hasAnyRole('MANAGER')")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping()
    public List<CategoryDto> getAllCategories() throws JsonProcessingException {
        return categoryService.findAll();
    }

    @GetMapping("/{catId}")
    public CategoryDto getCategory(@PathVariable String catId) {
        return categoryService.findById(catId);
    }

    @GetMapping("/childCategories")
    public List<CategoryDto> getChildCategories(@RequestParam(value = "catParentId", defaultValue = "") String catParentId) throws JsonProcessingException {
        return categoryService.childCategories(catParentId);
    }


    @PostMapping()
    public CategoryDto addCategory(@Valid @RequestBody CategoryDto categoryDto) {
        return categoryService.addCategory(categoryDto);
    }

    @PutMapping("update/{catId}")
    public CategoryDto updateCategory(@PathVariable("catId") String catId,@Valid @RequestBody CategoryDto categoryDto) {
        return categoryService.save(catId,categoryDto);
    }

    @DeleteMapping("/{catId}")
    public ResponseEntity<String> deleteCategory(@PathVariable("catId") String catId) throws IOException {
        categoryService.delete(catId);
        return ResponseEntity.ok("Deleted Category");
    }

    @PostMapping("/upBackgroundImgCategory")
    public ResponseEntity<String> upBackgroundImg(@RequestParam("file") MultipartFile file,
                                                             @RequestParam("catId") String catId) throws IOException {
        return categoryService.updateCatBackground(file,catId);

    }

}
