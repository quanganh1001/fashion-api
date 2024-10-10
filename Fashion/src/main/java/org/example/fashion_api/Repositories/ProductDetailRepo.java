package org.example.fashion_api.Repositories;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ProductDetailRepo extends JpaRepository<ProductDetail, Long> {
    Boolean existsByCode(String code);

    List<ProductDetail> findAllByProductId(Long productId);

    @Modifying
    @Query(value = "UPDATE products_detail SET is_activated = :status WHERE id = :productDetailId", nativeQuery = true)
    @Transactional
    void setIsActivated(@Param("productDetailId") Long productDetailId, @Param("status") Boolean status);


    List<ProductDetail> searchProductDetailByProductProductNameContainingIgnoreCaseAndIsActivatedTrue(String key);

}
