package org.example.fashion_api.Services.ProductService;

import org.example.fashion_api.Models.Product.CreateProductDto;
import org.example.fashion_api.Models.Product.ProductRes;
import org.example.fashion_api.Models.Product.UpdateProductDto;

import java.rmi.AlreadyBoundException;
import java.util.List;


public interface ProductService {

    List<ProductRes> getAllProducts();

    ProductRes getProduct(String productId);

    ProductRes updateProduct(String productId, UpdateProductDto updateProductDto);

    void deleteProduct(String productId);

    ProductRes addProduct(CreateProductDto createProductDTO);

    Boolean findByImgSizeEnumUrl(String url);
}
