package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Stored.SalesStored;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;

@Repository
public interface SalesStoredRepo extends JpaRepository<SalesStored,Long> {
    @Query(value = "CALL GetSalesSent(:startDate,:endDate)",
            nativeQuery = true)
    SalesStored findSaleSentStored(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    @Query(value = "CALL GetAllSalesSuccess(:startDate,:endDate)",
            nativeQuery = true)
    SalesStored findAllSaleSuccess(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    @Query(value = "CALL GetSalesSuccessAtStore(:startDate,:endDate,:store)",
            nativeQuery = true)
    SalesStored findSaleSuccessAtStore(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate,@Param("store") Long store);
}
