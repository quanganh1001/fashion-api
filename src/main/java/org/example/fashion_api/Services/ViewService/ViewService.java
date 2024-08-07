package org.example.fashion_api.Services.ViewService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.Views.TopProductView;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

public interface ViewService {

    List<ProductRes> selectListProducts(String selected) throws JsonProcessingException;

    List<TopProductView> findTopProduct(LocalDate startDate, LocalDate endDate) throws JsonProcessingException;
}
