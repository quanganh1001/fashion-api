package org.example.fashion_api.Services.ImgProductService;

import org.example.fashion_api.Models.ImgProduct.ImgProductRes;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ImgProductService {
    List<ImgProductRes> imgProductByProductId(String productId);

    void deleteImgProduct(Long id) throws IOException;

    void createImgProduct(String productId, MultipartFile[] file) throws IOException;
}
