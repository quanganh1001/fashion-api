package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Stored.TopProductStored;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface TopProductStoredRepo extends JpaRepository<TopProductStored,Long> {
    @Query(value = "CALL GetTopProduct(:startDate, :endDate)", nativeQuery = true)
    List<TopProductStored> findTopProduct(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
}
