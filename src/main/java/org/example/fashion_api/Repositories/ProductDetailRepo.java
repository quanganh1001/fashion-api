package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductDetailRepo extends JpaRepository<ProductDetail, Long> {
    Boolean existsByCode(String code);

    ProductDetail findByCode(String code);

    List<ProductDetail> findAllByProductProductId(String productId);
}
