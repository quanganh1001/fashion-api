package org.example.fashion_api.Services.StoredService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.Stored.SalesStored;
import org.example.fashion_api.Models.Stored.TopProductStored;

import java.time.LocalDate;
import java.util.List;

public interface StoredService {

    List<TopProductStored> findTopProduct(LocalDate startDate, LocalDate endDate) throws JsonProcessingException;

    SalesStored findSalesSent(LocalDate startDate, LocalDate endDate) throws JsonProcessingException;

    SalesStored findSalesSuccess(LocalDate startDate, LocalDate endDate) throws JsonProcessingException;
}
