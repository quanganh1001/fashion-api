package org.example.fashion_api.Controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.validation.Valid;
import org.example.fashion_api.Models.Product.*;
import org.example.fashion_api.Models.ProductDetail.ProductDetail;
import org.example.fashion_api.Services.ProductService.ProductService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@PreAuthorize("hasAnyRole('MANAGER')")
@RequestMapping("/products")
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private RedisService redisService;


    @GetMapping()
    public ProductPageRes getAllProducts(@RequestParam(defaultValue = "",required = false) String keyword,
                                         @RequestParam(defaultValue = "1") int page,
                                         @RequestParam(defaultValue = "10") int limit) throws JsonProcessingException {
        return productService.getAllProducts(keyword,page-1,limit);
    }

    @GetMapping("/{productId}")
    public ProductRes getProduct(@PathVariable("productId") String productId){
        return productService.getProduct(productId);
    }

    @GetMapping("/getByCategory/{catId}")
    public ProductPageRes getProductsByCategory(@RequestParam(defaultValue = "",required = false) String keyword,
                                                  @RequestParam(defaultValue = "0") int page,
                                                  @RequestParam(defaultValue = "10") int limit,
                                                  @PathVariable String catId) throws JsonProcessingException {
        return productService.getAllProductsByCategory(keyword,page,limit,catId);
    }

    @PostMapping()
    public ProductRes addProduct(@Valid @RequestBody CreateProductDto createProductDTO){
        return productService.addProduct(createProductDTO);
    }

    @PutMapping("/{productId}")
    public ProductRes updateProduct(@Valid @RequestBody UpdateProductDto updateProductDto, @PathVariable String productId) {
        return productService.updateProduct(productId, updateProductDto);
    }

    @DeleteMapping("/{productId}")
    public ResponseEntity<String> deleteProduct(@PathVariable String productId){
        productService.deleteProduct(productId);
        return ResponseEntity.ok("deleted");
    }

    @PostMapping("/updateProductBackground")
    public ResponseEntity<String> updateProductBackground(@RequestParam("file") MultipartFile file,
                                                  @RequestParam("productId") String productId) throws IOException {
        return productService.updateProductBackground(file,productId);

    }
}
