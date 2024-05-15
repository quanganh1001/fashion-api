package org.example.fashion_api.Services.ProductService;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.Products.CreateProductDto;
import org.example.fashion_api.Models.Products.PageProductRes;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.Products.UpdateProductDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;


public interface ProductService {

    PageProductRes getAllProducts(String keyword, int page, int limit) throws JsonProcessingException;

    ProductRes getProduct(Long productId);

    @Transactional
    ProductRes updateProduct(Long productId, UpdateProductDto updateProductDto);

    void deleteProduct(String productId);

    @Transactional
    ProductRes addProduct(CreateProductDto createProductDTO);


    @Transactional
    ResponseEntity<String> updateProductBackground(MultipartFile file, Long productId) throws IOException;

    PageProductRes getAllProductsByCategory(String keyword, int page, int limit, Long catId) throws JsonProcessingException;
}
