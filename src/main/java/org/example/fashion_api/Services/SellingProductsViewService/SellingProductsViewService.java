package org.example.fashion_api.Services.SellingProductsViewService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.SellingProductsView.SellingProductsView;

import java.util.List;

public interface SellingProductsViewService {

    List<ProductRes> selectListProducts(String selected) throws JsonProcessingException;
}
