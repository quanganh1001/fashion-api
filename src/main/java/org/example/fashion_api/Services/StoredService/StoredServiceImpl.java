package org.example.fashion_api.Services.StoredService;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Mapper.ProductMapper;
import org.example.fashion_api.Models.Categories.CategoryRes;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.Stored.TopProductStored;
import org.example.fashion_api.Repositories.ProductRepo;
import org.example.fashion_api.Repositories.SellingProductsViewRepo;
import org.example.fashion_api.Repositories.TopProductStoredRepo;
import org.example.fashion_api.Services.CategoryService.CategoryService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class StoredServiceImpl implements StoredService {

    private final SellingProductsViewRepo sellingProductsViewRepo;
    private final ProductRepo productRepo;
    private final CategoryService categoryService;
    private final ProductMapper productMapper;
    private final TopProductStoredRepo topProductStoredRepo;




    @Override
    public List<TopProductStored> findTopProduct(LocalDate startDate, LocalDate endDate) throws JsonProcessingException {
        if (startDate == null || endDate == null){
            startDate = LocalDate.now().minusDays(365);
            endDate = LocalDate.now();
        }
        return topProductStoredRepo.findTopProduct(startDate,endDate);
    }


}
