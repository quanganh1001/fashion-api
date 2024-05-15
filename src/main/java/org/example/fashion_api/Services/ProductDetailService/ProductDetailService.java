package org.example.fashion_api.Services.ProductDetailService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.ProductsDetails.CreateProductDetailDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Models.ProductsDetails.UpdateProductDetailDto;

import java.util.List;

public interface ProductDetailService {

    List<ProductDetailRes> findAllProductDetails(Long productId) throws JsonProcessingException;

    ProductDetailRes getProductDetail(Long id);

    ProductDetailRes createProductDetail(CreateProductDetailDto createProductDetailDto);

    ProductDetailRes updateProductDetail(Long productDetailId, UpdateProductDetailDto dto);

    void deleteProductDetail(Long productDetailId);
}
