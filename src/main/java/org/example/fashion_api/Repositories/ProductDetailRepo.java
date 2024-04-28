package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.ProductDetail.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductDetailRepo extends JpaRepository<ProductDetail, Long> {
    Boolean existsByCode(String code);

    ProductDetail findByCode(String code);
}
