package org.example.fashion_api.Services.ImgProductService;

import org.example.fashion_api.Models.ImgsProducts.ImgProduct;
import org.example.fashion_api.Models.ImgsProducts.ImgProductRes;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ImgProductService {
    List<ImgProductRes> imgProductByProductId(Long productId);

    void deleteImgProduct(Long id) throws IOException;

    void createImgProduct(Long productId, MultipartFile[] file) throws IOException;
}
