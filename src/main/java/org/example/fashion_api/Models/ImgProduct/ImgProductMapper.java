package org.example.fashion_api.Models.ImgProduct;

import org.example.fashion_api.Models.ProductDetail.ProductDetailRes;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ImgProductMapper {

    ImgProductRes imgProductToImgProductRes(ImgProduct imgProduct);

    List<ImgProductRes> toImgProductList(List<ImgProduct> imgProductList);
}
