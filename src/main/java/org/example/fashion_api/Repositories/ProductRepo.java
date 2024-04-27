package org.example.fashion_api.Repositories;


import org.example.fashion_api.Models.Product.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductRepo extends JpaRepository<Product,String> {

    Boolean existsByProductId(String productId);

    Boolean existsByProductName(String productName);

    @Modifying
    @Query(value = "UPDATE products SET image_background = :imageUrl WHERE product_id = :productId",
            nativeQuery = true)
    void updateCatBackground(@Param("imageUrl") String imageUrl, @Param("productId") String productId);
}
