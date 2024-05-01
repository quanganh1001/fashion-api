package org.example.fashion_api.Services.ProductService;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.Product.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.rmi.AlreadyBoundException;
import java.util.List;


public interface ProductService {

    ProductPageRes getAllProducts(String keyword, int page, int limit) throws JsonProcessingException;

    ProductRes getProduct(String productId);

    ProductRes updateProduct(String productId, UpdateProductDto updateProductDto);

    void deleteProduct(String productId);

    @Transactional
    ProductRes addProduct(CreateProductDto createProductDTO);

    @Transactional
    ResponseEntity<String> updateProductBackground(MultipartFile file, String ProductId) throws IOException;

    ProductPageRes getAllProductsByCategory(String keyword,int page,int limit,String catId) throws JsonProcessingException;
}
