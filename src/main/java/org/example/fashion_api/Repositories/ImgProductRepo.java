package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.ImgProduct.ImgProduct;
import org.example.fashion_api.Models.Product.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ImgProductRepo extends JpaRepository<ImgProduct, Long> {
    List<ImgProduct> findAllByProductProductId(String productId);
}
