package org.example.fashion_api.Services.ProductDetailService;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.ProductDetailMapper;
import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.ProductsDetails.*;
import org.example.fashion_api.Repositories.ColorRepo;
import org.example.fashion_api.Repositories.InvoiceDetailRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Repositories.ProductRepo;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductDetailServiceImpl implements ProductDetailService{
    private final ProductDetailRepo productDetailRepo;
    private final ProductDetailMapper productDetailMapper;
    private final RedisService redisService;
    private final ProductRepo productRepo;
    private final ColorRepo colorRepo;

    @Override
    public List<ProductDetailRes> findAllProductDetails(Long productId) throws JsonProcessingException {
        String keyRedis = "findAllProductDetails("+productId+")";
        List<ProductDetailRes> productDetailsRes = redisService.getListRedis(keyRedis,ProductDetailRes.class);

        if (productDetailsRes == null) {
            productDetailsRes = productDetailMapper.productDetailsToProductDetailRes(productDetailRepo.findAllByProductId(productId));

            redisService.saveRedis(keyRedis,productDetailsRes);
        }
        return productDetailsRes;
    }

    @Override
    public ProductDetailRes getProductDetail(Long id){
        return productDetailMapper.productDetailToProductDetailRes(productDetailRepo.findById(id).orElseThrow(()-> new NotFoundException(id.toString())));
    }

    @Override
    public void createProductDetail(CreateProductDetailDto dto){
        if (productDetailRepo.existsByCode(dto.getCode())){
            throw new AlreadyExistException("Product detail code");
        }
        ProductDetail productDetail = productDetailMapper.createProductDetailToProductDetail(dto,
                new ProductDetail());

        productDetailRepo.save(productDetail);
    }

    @Override
    public ProductDetailRes updateProductDetail(Long productDetailId, UpdateProductDetailDto dto){

        ProductDetail currenProductDetail = productDetailRepo.findById(productDetailId).orElseThrow(()-> new NotFoundException(productDetailId.toString()));

        if(!Objects.equals(productDetailId, currenProductDetail.getId()) && productDetailRepo.existsByCode(dto.getCode())){
            throw new AlreadyExistException("Product detail code");
        }

        if(currenProductDetail.getIsActivated() != dto.getIsActivated() && dto.getIsActivated()){
            Optional<Product> product = productRepo.findById(currenProductDetail.getProduct().getId());
            if (product.isPresent() && !product.get().getIsActivated()) {
                throw new BadRequestException("Product is not activated");
            }
        }

        ProductDetail productDetail = productDetailMapper.updateProductDetailToProductDetail(dto,currenProductDetail);
        System.out.println(productDetail);

        Color color = colorRepo.findById(dto.getColorId()).orElseThrow(()-> new NotFoundException(dto.getColorId().toString()));
        productDetail.setColor(color);

        productDetailRepo.save(productDetail);
        return productDetailMapper.productDetailToProductDetailRes(productDetail);
    }

    @Override
    public void deleteProductDetail(Long productDetailId){
        ProductDetail productDetail = productDetailRepo.findById(productDetailId).orElseThrow(()-> new NotFoundException(productDetailId.toString()));
        productDetailRepo.delete(productDetail);
    }

    @Override
    public List<ProductDetailRes> findByKey(String key) {
        List<ProductDetail> productDetails =
        productDetailRepo.searchProductDetailByProductProductNameContainingIgnoreCaseAndIsActivatedTrue(key);
        return productDetailMapper.productDetailsToProductDetailRes(productDetails);
    }
}
