package org.example.fashion_api.Mapper;




import org.example.fashion_api.Models.Products.CreateProductDto;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.Products.UpdateProductDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring",uses = {ProductDetailMapper.class},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ProductMapper {


    List<ProductRes> productsToProductRes(List<Product> products);


    @Mapping(target = "catId", source = "category.id")
    @Mapping(target = "productsDetails", source = "productsDetails")
    ProductRes productToProductRes(Product product);


    @Mapping(target = "category.id", source = "catId")
    Product createProductDtoToProduct(CreateProductDto createProductDTO, @MappingTarget Product product);

    @Mapping(target = "category.id", source = "catId")
    Product updateProductDtoToProduct(UpdateProductDto updateProductDto, @MappingTarget Product product);
}
