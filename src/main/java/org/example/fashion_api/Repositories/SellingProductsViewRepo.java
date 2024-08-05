package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.SellingProductsView.SellingProductsView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SellingProductsViewRepo extends JpaRepository<SellingProductsView,Long> {
    List<SellingProductsView> findTop10ByOrderByTotalSalesDesc();
}
