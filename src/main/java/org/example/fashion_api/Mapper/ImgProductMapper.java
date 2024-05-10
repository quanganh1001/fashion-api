package org.example.fashion_api.Mapper;

import org.example.fashion_api.Models.ImgsProducts.ImgProduct;
import org.example.fashion_api.Models.ImgsProducts.ImgProductRes;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ImgProductMapper {

    ImgProductRes imgProductToImgProductRes(ImgProduct imgProduct);

    List<ImgProductRes> toImgProductList(List<ImgProduct> imgProductList);
}