package org.example.fashion_api.Services.ProductDetailService;

import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.ProductDetail.*;
import org.example.fashion_api.Repositories.ProductDetailRepo;
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

    @Override
    public List<ProductDetailRes> findAllProductDetails() {
        return productDetailMapper.productDetailsToProductDetailRes(productDetailRepo.findAll());
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
        ProductDetail currenProductDetail = productDetailRepo.findByCode(dto.getCode());
        if(!Objects.equals(productDetailId, currenProductDetail.getProductDetailId()) && productDetailRepo.existsByCode(dto.getCode())){
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
