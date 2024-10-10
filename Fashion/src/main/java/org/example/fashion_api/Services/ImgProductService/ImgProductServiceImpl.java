package org.example.fashion_api.Services.ImgProductService;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.ImgsProducts.ImgProduct;
import org.example.fashion_api.Mapper.ImgProductMapper;
import org.example.fashion_api.Models.ImgsProducts.ImgProductRes;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Repositories.ImgProductRepo;
import org.example.fashion_api.Repositories.ProductRepo;
import org.example.fashion_api.Services.CloudinaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ImgProductServiceImpl implements ImgProductService {
    private final ImgProductRepo imgProductRepo;
    private final ImgProductMapper imgProductMapper;
    private final CloudinaryService cloudinaryService;
    private final ProductRepo productRepo;

    @Override
    public List<ImgProductRes> imgProductByProductId(Long productId) {
        List<ImgProduct> imgProducts = imgProductRepo.findAllByProductId(productId);
        return imgProductMapper.toImgProductList(imgProducts);
    }

    @Override
    public void deleteImgProduct(Long id) throws IOException {
        ImgProduct imgProduct = imgProductRepo.findById(id).orElseThrow(() -> new NotFoundException("Image"));
        imgProductRepo.delete(imgProduct);
        // delete from cloud
        cloudinaryService.deleteImageByUrl(imgProduct.getFileImg());
    }

    @Override
    public void createImgProduct(Long productId, MultipartFile[] files) throws IOException {


        Product product = productRepo.findById(productId).orElseThrow(() -> new NotFoundException("Product"));

        //add all image to cloud and db
        for (MultipartFile file : files) {


            Map<String, Object> uploadResult = cloudinaryService.upload(file);

            String imageUrl = uploadResult.get("secure_url").toString();

            ImgProduct imgProduct = new ImgProduct();
            imgProduct.setFileImg(imageUrl);
            imgProduct.setProduct(product);
            imgProductRepo.save(imgProduct);
        }
    }
}
