package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.ImgsProducts.ImgProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ImgProductRepo extends JpaRepository<ImgProduct, Long> {
    List<ImgProduct> findAllByProductId(Long productId);
}
