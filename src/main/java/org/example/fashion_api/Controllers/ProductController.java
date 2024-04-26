package org.example.fashion_api.Controllers;

import org.example.fashion_api.Models.Product.Product;
import org.example.fashion_api.Models.Product.ProductDTO;
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
    public List<Product> getAllProducts(){
        return productService.getAllProducts();
    }

    @GetMapping("/{productId}")
    public ProductDTO getProduct(@PathVariable("productId") String productId){
        return productService.getProduct(productId);
    }

    @PostMapping()
    public ProductDTO addProduct(@RequestBody ProductDTO productDTO){
        return productService.addProduct(productDTO);
    }

    @PutMapping("/{productId}")
    public ProductDTO updateProduct(@RequestBody ProductDTO productDTO,@PathVariable String productId) throws AlreadyBoundException {
        return productService.updateProduct(productId,productDTO);
    }

    @DeleteMapping("/{productId}")
    public ResponseEntity<String> deleteProduct(@RequestParam String productId){
        productService.deleteProduct(productId);
        return ResponseEntity.ok("deleted");
    }
}
