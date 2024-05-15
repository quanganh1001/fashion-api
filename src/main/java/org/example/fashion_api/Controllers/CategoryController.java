package org.example.fashion_api.Controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.validation.Valid;
import org.example.fashion_api.Models.Categories.CategoryDto;
import org.example.fashion_api.Models.Categories.CategoryRes;
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
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping()
    public ResponseEntity<List<CategoryRes>> getAllCategories() throws JsonProcessingException {
        return ResponseEntity.ok(categoryService.findAll());
    }

    @GetMapping("/{catId}")
    public ResponseEntity<CategoryRes> getCategory(@PathVariable Long catId) {
        return ResponseEntity.ok(categoryService.findById(catId));
    }

    @GetMapping("/childCategories")
    public ResponseEntity<List<CategoryRes>> getChildCategories(@RequestParam(value = "catParentId",
            defaultValue = "") Long catParentId) throws JsonProcessingException {
        return ResponseEntity.ok(categoryService.childCategories(catParentId));
    }


    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping()
    public ResponseEntity<CategoryRes> addCategory(@Valid @RequestBody CategoryDto categoryDto) {
        return ResponseEntity.ok(categoryService.addCategory(categoryDto));
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @PutMapping("update/{catId}")
    public ResponseEntity<CategoryRes> updateCategory(@PathVariable("catId") Long catId,
                                                      @Valid @RequestBody CategoryDto categoryDto) {
        return ResponseEntity.ok(categoryService.save(catId,categoryDto));
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{catId}")
    public ResponseEntity<String> deleteCategory(@PathVariable("catId") Long catId) throws IOException {
        categoryService.delete(catId);
        return ResponseEntity.ok("Deleted Category");
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping("/upBackgroundImgCategory/{catId}")
    public ResponseEntity<String> upBackgroundImg(@RequestParam("file") MultipartFile file,
                                                             @PathVariable Long catId) throws IOException {
        return ResponseEntity.ok(categoryService.updateCatBackground(file,catId));

    }

}
