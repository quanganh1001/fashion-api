package org.example.fashion_api.Repositories;


import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.Products.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.awt.print.Pageable;
import java.util.List;

@Repository
public interface ProductRepo extends JpaRepository<Product,Long> {

    Boolean existsByProductCode(String productCode);

    @Modifying
    @Query(value = "UPDATE products SET image_background = :imageUrl WHERE id = :id",
            nativeQuery = true)
    void updateProductBackground(@Param("imageUrl") String imageUrl, @Param("id") Long id);


    @Query(value = "SELECT * FROM products WHERE cat_id IN (:categoryIds)", nativeQuery = true)
    List<Product> findAllByCategoryIds(@Param("categoryIds") List<Long> categoryIds);

    @Query(value = "SELECT * FROM products WHERE LOWER(product_name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(product_code) LIKE LOWER(CONCAT('%', :keyword, '%')) ", nativeQuery = true)
    Page<Product> findAllProductByKey(@Param("keyword") String keyword, PageRequest pageRequest);

    @Query(value = "SELECT * FROM products WHERE LOWER(product_name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(product_code) LIKE LOWER(CONCAT('%', :keyword, '%')) ", nativeQuery = true)
    List<Product> findAllProductByKey(@Param("keyword") String keyword);

    @Query(value = "SELECT * from products WHERE discount_price > 0 ",nativeQuery = true)
    List<Product> findAllSale();
}

