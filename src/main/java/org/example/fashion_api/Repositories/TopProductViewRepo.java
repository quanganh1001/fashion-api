package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Views.TopProductView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface TopProductViewRepo extends JpaRepository<TopProductView,Long> {
    @Query(value = "SELECT * from top_products WHERE (confirmation_at BETWEEN :startDate AND :endDate) LIMIT 10",
            nativeQuery = true)
    List<TopProductView> findTopProduct(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
}
