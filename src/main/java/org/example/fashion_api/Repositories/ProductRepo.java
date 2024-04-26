package org.example.fashion_api.Repositories;


import org.example.fashion_api.Models.Product.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepo extends JpaRepository<Product,String> {
    Boolean existsByProductId(String productId);
    Boolean existsByProductName(String productName);
}
