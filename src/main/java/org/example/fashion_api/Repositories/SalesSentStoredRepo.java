package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Stored.SalesSentStored;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface SalesSentStoredRepo extends JpaRepository<SalesSentStored,Long> {
    @Query(value = "SELECT * from sales_sent_view WHERE (confirmation_date BETWEEN :startDate AND :endDate)",
            nativeQuery = true)
    List<SalesSentStored> findSaleSentView(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
}
