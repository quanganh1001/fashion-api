package org.example.fashion_api.Controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import org.example.fashion_api.Models.Products.CreateProductDto;
import org.example.fashion_api.Models.Products.PageProductRes;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.Products.UpdateProductDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Services.ProductDetailService.ProductDetailService;
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
@RequestMapping("/products")
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductDetailService productDetailService;


    @Operation(summary = "get all products ")
    @GetMapping()
    public PageProductRes getAllProducts(@RequestParam(defaultValue = "",required = false) String keyword,
                                         @RequestParam(defaultValue = "1") int page,
                                         @RequestParam(defaultValue = "10") int limit) throws JsonProcessingException {
        return productService.getAllProducts(keyword,page-1,limit);
    }

    @Operation(summary = "get product ")
    @GetMapping("/{productId}")
    public ProductRes getProduct(@PathVariable("productId") Long productId){
        return productService.getProduct(productId);
    }

    @Operation(summary = "get product by catId ")
    @GetMapping("/getByCategory/{catId}")
    public PageProductRes getProductsByCategory(@RequestParam(defaultValue = "",required = false) String keyword,
                                                @RequestParam(defaultValue = "1") int page,
                                                @RequestParam(defaultValue = "10") int limit,
                                                @PathVariable Long catId) throws JsonProcessingException {
        return productService.getAllProductsByCategory(keyword,page-1,limit,catId);
    }

    @Operation(summary = "create product (role MANAGER) ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping()
    public ProductRes addProduct(@Valid @RequestBody CreateProductDto createProductDTO){
        return productService.addProduct(createProductDTO);
    }

    @Operation(summary = "update product (role MANAGER) ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PutMapping("/{productId}")
    public ProductRes updateProduct(@Valid @RequestBody UpdateProductDto updateProductDto,
                                    @PathVariable Long productId) {
        return productService.updateProduct(productId, updateProductDto);
    }

    @Operation(summary = "delete product (role MANAGER) ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{productId}")
    public ResponseEntity<String> deleteProduct(@PathVariable Long productId){
        productService.deleteProduct(productId);
        return ResponseEntity.ok("deleted");
    }


    @Operation(summary = "update image background product (role MANAGER) ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping("/updateProductBackground")
    public ResponseEntity<String> updateProductBackground(@RequestParam("file") MultipartFile file,
                                                  @RequestParam("productId") Long productId) throws IOException {
        return productService.updateProductBackground(file,productId);

    }

    @Operation(summary = "get product detail by productId")
    @GetMapping("/{productId}/productsDetail")
    public List<ProductDetailRes> getAllProductDetailsByProductId(@PathVariable("productId") Long productId) throws JsonProcessingException {
        return productDetailService.findAllProductDetails(productId);
    }

}
