package org.example.fashion_api.Services.ProductService;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.Product.CreateProductDto;
import org.example.fashion_api.Models.Product.ProductRes;
import org.example.fashion_api.Models.Product.UpdateProductDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.rmi.AlreadyBoundException;
import java.util.List;


public interface ProductService {

    List<ProductRes> getAllProducts();

    ProductRes getProduct(String productId);

    ProductRes updateProduct(String productId, UpdateProductDto updateProductDto);

    void deleteProduct(String productId);

    ProductRes addProduct(CreateProductDto createProductDTO);

    Boolean findByImgSizeEnumUrl(String url);

    @Transactional
    ResponseEntity<String> updateProductBackground(MultipartFile file, String ProductId) throws IOException;
}
