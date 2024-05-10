package org.example.fashion_api.Models.ProductDetail;


import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Product.Product;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ProductDetailMapper {

    @Mapping(target = "product", source = "product")
    @Mapping(target = "productDetailId", source = "productDetailId")
    ProductDetailRes productDetailToProductDetailRes(ProductDetail productDetail);

    @Mapping(target = "product", source = "product")
    @Mapping(target = "color", source = "color")
    List<ProductDetailRes> productDetailsToProductDetailRes(List<ProductDetail> productDetails);

    @Mapping(target = "product.productId", source = "productId")
    @Mapping(target = "color.colorId", source = "colorId")
    ProductDetail createProductDetailToProductDetail(CreateProductDetailDto createProductDetailDto, @MappingTarget ProductDetail productDetail);

    @Mapping(target = "product.productId", source = "productId")
    @Mapping(target = "color.colorId", source = "colorId")
    ProductDetail updateProductDetailToProductDetail(UpdateProductDetailDto updateProductDetailDto, @MappingTarget ProductDetail productDetail);
}
