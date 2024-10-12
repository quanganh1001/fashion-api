package org.example.fashion_api.Services.ProductDetailService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.ProductsDetails.CreateProductDetailDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Models.ProductsDetails.UpdateProductDetailDto;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ProductDetailService {

    List<ProductDetailRes> findAllProductDetails(Long productId) throws JsonProcessingException;

    ProductDetailRes getProductDetail(Long id);

    void createProductDetail(CreateProductDetailDto createProductDetailDto);

    ProductDetailRes updateProductDetail(Long productDetailId, UpdateProductDetailDto dto);

    void deleteProductDetail(Long productDetailId);

    List<ProductDetailRes> findByKey(String key);

    String updateProductDetailBackground(MultipartFile file, Long productDetailId) throws IOException;
}
