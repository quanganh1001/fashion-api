package org.example.fashion_api.Controllers;

import jakarta.validation.Valid;
import org.example.fashion_api.Models.Product.CreateProductDto;
import org.example.fashion_api.Models.Product.ProductRes;
import org.example.fashion_api.Models.Product.UpdateProductDto;
import org.example.fashion_api.Services.ProductService.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.rmi.AlreadyBoundException;
import java.util.List;

@RestController
@PreAuthorize("hasAnyRole('MANAGER')")
@RequestMapping("/products")
public class ProductController {
    @Autowired
    private ProductService productService;

    @GetMapping()
    public List<ProductRes> getAllProducts(){
        return productService.getAllProducts();
    }

    @GetMapping("/{productId}")
    public ProductRes getProduct(@PathVariable("productId") String productId){
        return productService.getProduct(productId);
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
}
