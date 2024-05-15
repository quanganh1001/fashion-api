package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.ImgsProducts.ImgProduct;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ImgProductRepo extends JpaRepository<ImgProduct, Long> {
    List<ImgProduct> findAllByProductId(Long productId);
}
