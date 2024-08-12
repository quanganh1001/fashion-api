package org.example.fashion_api.Mapper;


import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.ProductsDetails.CreateProductDetailDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Models.ProductsDetails.UpdateProductDetailDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ProductDetailMapper {

    @Mapping(target = "color", source = "color.name")
    @Mapping(target = "price", source = "product.price")
    @Mapping(target = "discountPrice", source = "product.discountPrice")
    @Mapping(target = "discountPercent", source = "product.discountPercent")
    @Mapping(target = "imageBackground", source = "product.imageBackground")
    @Mapping(target = "productName", source = "product.productName")
    @Mapping(target = "colorId", source = "color.id")
    ProductDetailRes productDetailToProductDetailRes(ProductDetail productDetail);

    @Mapping(target = "imageBackground", source = "product.imageBackground")
    List<ProductDetailRes> productDetailsToProductDetailRes(List<ProductDetail> productDetails);


    @Mapping(target = "product.id", source = "productId")
    @Mapping(target = "color.id", source = "colorId")
    ProductDetail createProductDetailToProductDetail(CreateProductDetailDto createProductDetailDto, @MappingTarget ProductDetail productDetail);

    ProductDetail updateProductDetailToProductDetail(UpdateProductDetailDto updateProductDetailDto, @MappingTarget ProductDetail productDetail);
}
