package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductDetailRepo extends JpaRepository<ProductDetail, Long> {
    Boolean existsByCode(String code);

    List<ProductDetail> findAllByProductId(Long productId);


}
