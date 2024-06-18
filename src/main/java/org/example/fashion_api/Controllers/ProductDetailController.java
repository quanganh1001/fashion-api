package org.example.fashion_api.Controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import org.example.fashion_api.Models.ProductsDetails.CreateProductDetailDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Models.ProductsDetails.UpdateProductDetailDto;
import org.example.fashion_api.Services.ProductDetailService.ProductDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/productsDetail")
public class ProductDetailController {
    @Autowired
    private ProductDetailService productDetailService;


    @Operation(summary = "get product detail")
    @GetMapping("/{productDetailId}")
    public ResponseEntity<ProductDetailRes> getProductDetail(@PathVariable Long productDetailId) {
        return ResponseEntity.ok(productDetailService.getProductDetail(productDetailId));
    }

    @Operation(summary = "find product detail by keyword")
    @GetMapping()
    public ResponseEntity<List<ProductDetailRes>> findByKey(@RequestParam(defaultValue = "") String key) {
        return ResponseEntity.ok(productDetailService.findByKey(key));
    }

    @Operation(summary = "create product detail (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping()
    public ResponseEntity<String> createProductDetail(@Valid @RequestBody CreateProductDetailDto createProductDetailDto) {
        productDetailService.createProductDetail(createProductDetailDto);
        return ResponseEntity.ok("Product detail created");
    }

    @Operation(summary = "update product detail (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PutMapping("/{productDetailId}")
    public ResponseEntity<ProductDetailRes> updateProductDetail(@PathVariable Long productDetailId, @RequestBody UpdateProductDetailDto updateProductDetailDto) {
        return ResponseEntity.ok(productDetailService.updateProductDetail(productDetailId, updateProductDetailDto));
    }

    @Operation(summary = "delete product detail (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{productDetailId}")
    public ResponseEntity<String> deleteProductDetail(@PathVariable Long productDetailId) {
        productDetailService.deleteProductDetail(productDetailId);
        return ResponseEntity.ok("Product detail deleted successfully.");
    }
}
