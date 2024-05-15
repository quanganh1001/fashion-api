package org.example.fashion_api.Services.ProductDetailService;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.ProductDetailMapper;
import org.example.fashion_api.Models.ProductsDetails.*;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class ProductDetailServiceImpl implements ProductDetailService{
    @Autowired
    private ProductDetailRepo productDetailRepo;
    @Autowired
    private ProductDetailMapper productDetailMapper;
    @Autowired
    private RedisService redisService;

    @Override
    public List<ProductDetailRes> findAllProductDetails(Long productId) throws JsonProcessingException {
        String keyRedis = "findAllProductDetails("+productId+")";
        List<ProductDetail> productDetails = redisService.getListRedis(keyRedis,ProductDetail.class);

        if (productDetails == null) {
            productDetails = productDetailRepo.findAllByProductId(productId);

            redisService.saveRedis(keyRedis,productDetails);
        }
        return productDetailMapper.productDetailsToProductDetailRes(productDetails);
    }

    @Override
    public ProductDetailRes getProductDetail(Long id){
        return productDetailMapper.productDetailToProductDetailRes(productDetailRepo.findById(id).orElseThrow(()-> new NotFoundException(id.toString())));
    }

    @Override
    public ProductDetailRes createProductDetail(CreateProductDetailDto dto){
        if (productDetailRepo.existsByCode(dto.getCode())){
            throw new AlreadyExistException(dto.getCode());
        }
        ProductDetail productDetail = productDetailMapper.createProductDetailToProductDetail(dto,new ProductDetail());
        productDetailRepo.save(productDetail);
        return productDetailMapper.productDetailToProductDetailRes(productDetail);
    }

    @Override
    public ProductDetailRes updateProductDetail(Long productDetailId, UpdateProductDetailDto dto){
        ProductDetail currenProductDetail = productDetailRepo.findById(productDetailId).orElseThrow(()-> new NotFoundException(productDetailId.toString()));

        if(!Objects.equals(productDetailId, currenProductDetail.getId()) && productDetailRepo.existsByCode(dto.getCode())){
            throw new AlreadyExistException(dto.getCode());
        }

        ProductDetail productDetail = productDetailMapper.updateProductDetailToProductDetail(dto,currenProductDetail);
        productDetailRepo.save(productDetail);
        return productDetailMapper.productDetailToProductDetailRes(productDetail);
    }

    @Override
    public void deleteProductDetail(Long productDetailId){
        ProductDetail productDetail = productDetailRepo.findById(productDetailId).orElseThrow(()-> new NotFoundException(productDetailId.toString()));
        productDetailRepo.delete(productDetail);
    }
}
