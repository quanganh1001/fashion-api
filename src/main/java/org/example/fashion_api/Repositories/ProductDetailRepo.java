package org.example.fashion_api.Repositories;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductDetailRepo extends JpaRepository<ProductDetail, Long> {
    Boolean existsByCode(String code);

    List<ProductDetail> findAllByProductId(Long productId);

    @Modifying
    @Query(value = "UPDATE products_detail SET is_activated = :status WHERE id = :productDetailId", nativeQuery = true)
    @Transactional
    void setIsActivated(@Param("productDetailId") Long productDetailId, @Param("status") Boolean status);

    @Query(value = "SELECT pd.* FROM products_detail pd " +
            "JOIN products p ON pd.product_id = p.id " +
            "WHERE p.product_code LIKE %:key% " +
            "OR p.product_name LIKE %:key% " +
            "OR pd.is_activated = true",
            nativeQuery = true)
    List<ProductDetail> findAllByKey(String key);

}
