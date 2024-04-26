package org.example.fashion_api.Services.ProductService;

import org.example.fashion_api.Models.Product.Product;
import org.example.fashion_api.Models.Product.ProductDTO;
import org.springframework.stereotype.Service;

import java.rmi.AlreadyBoundException;
import java.util.List;


public interface ProductService {

    List<Product> getAllProducts();

    ProductDTO getProduct(String productId);

    ProductDTO updateProduct(String productId, ProductDTO productDTO) throws AlreadyBoundException;

    void deleteProduct(String productId);

    ProductDTO addProduct(ProductDTO productDTO);
}
