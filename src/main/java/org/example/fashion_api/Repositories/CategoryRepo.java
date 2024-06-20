package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Categories.Category;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CategoryRepo extends JpaRepository<Category,Long> {

    Boolean existsByCategoryCode(String categoryCode);

    @Modifying
    @Query(value = "UPDATE categories SET cat_background = :urlImage WHERE id = :catId",
            nativeQuery = true)
    void updateCatBackground(@Param("urlImage") String urlImage, @Param("catId") Long catId);

    List<Category> findAllByCatParentId(Long catId);



}
