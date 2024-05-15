package org.example.fashion_api.Repositories;


import org.example.fashion_api.Models.Products.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductRepo extends JpaRepository<Product,Long> {

    boolean existsById(Long productId);

    Boolean existsByProductName(String productName);

    @Modifying
    @Query(value = "UPDATE products SET image_background = :imageUrl WHERE id = :id",
            nativeQuery = true)
    void updateProductBackground(@Param("imageUrl") String imageUrl, @Param("id") Long id);


    @Query(value = "SELECT * FROM products WHERE cat_id = :catId AND (LOWER(product_name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(product_id) LIKE LOWER(CONCAT('%', :keyword, '%')))  ", nativeQuery = true)
    Page<Product> findAllByCategoryCatId(@Param("catId") Long catId,@Param("keyword") String keyword, PageRequest pageRequest);


    @Query(value = "SELECT * FROM products WHERE LOWER(product_name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(product_id) LIKE LOWER(CONCAT('%', :keyword, '%')) ", nativeQuery = true)
    Page<Product> findAllProductByKey(@Param("keyword") String keyword, PageRequest pageRequest);

}
