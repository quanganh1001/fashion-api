package org.example.fashion_api.Services.ProductDetailService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.ProductDetail.CreateProductDetailDto;
import org.example.fashion_api.Models.ProductDetail.ProductDetailRes;
import org.example.fashion_api.Models.ProductDetail.UpdateProductDetailDto;

import java.util.List;

public interface ProductDetailService {
    List<ProductDetailRes> findAllProductDetails(String productId) throws JsonProcessingException;

    ProductDetailRes getProductDetail(Long id);

    ProductDetailRes createProductDetail(CreateProductDetailDto createProductDetailDto);

    ProductDetailRes updateProductDetail(Long productDetailId, UpdateProductDetailDto dto);

    void deleteProductDetail(Long productDetailId);
}
