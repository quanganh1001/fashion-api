package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Category.Category;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CategoryRepo extends JpaRepository<Category,String> {
    Boolean existsByCatName(String catName);

    @Modifying
    @Query(value = "UPDATE categories SET cat_background = :urlImage WHERE cat_id = :catId",
            nativeQuery = true)
    void updateCatBackground(@Param("urlImage") String urlImage, @Param("catId") String catId);

    List<Category> findAllByCatParentCatId(String catId);
}