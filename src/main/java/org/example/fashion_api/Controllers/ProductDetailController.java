package org.example.fashion_api.Controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.ProductDetail.CreateProductDetailDto;
import org.example.fashion_api.Models.ProductDetail.ProductDetailRes;
import org.example.fashion_api.Models.ProductDetail.UpdateProductDetailDto;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Services.ProductDetailService.ProductDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/productsDetail")
@PreAuthorize("hasAnyRole('MANAGER')")
public class ProductDetailController {
    @Autowired
    private ProductDetailService productDetailService;

    @GetMapping()
    public List<ProductDetailRes> getAllProductDetails(@RequestParam() String productId) throws JsonProcessingException {
        return productDetailService.findAllProductDetails(productId);
    }

    @GetMapping("/{productDetailId}")
    public ProductDetailRes getProductDetail(@PathVariable Long productDetailId) {
        return productDetailService.getProductDetail(productDetailId);
    }

    @PostMapping()
    public ProductDetailRes createProductDetail(@RequestBody CreateProductDetailDto createProductDetailDto) {
        return productDetailService.createProductDetail(createProductDetailDto);
    }

    @PutMapping("/{productDetailId}")
    public ProductDetailRes updateProductDetail(@PathVariable Long productDetailId, @RequestBody UpdateProductDetailDto updateProductDetailDto) {
        return productDetailService.updateProductDetail(productDetailId, updateProductDetailDto);
    }

    @DeleteMapping("/{productDetailId}")
    public ResponseEntity<String> deleteProductDetail(@PathVariable Long productDetailId) {
        productDetailService.deleteProductDetail(productDetailId);
        return ResponseEntity.ok("Product detail deleted successfully.");
    }
}