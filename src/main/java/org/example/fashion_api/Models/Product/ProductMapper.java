package org.example.fashion_api.Models.Product;




import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ProductMapper {

    List<ProductRes> productsToProductRes(List<Product> products);


    @Mapping(target = "catId", source = "category.catId")
    ProductRes productToProductRes(Product product);


    @Mapping(target = "category.catId", source = "catId")
    Product createProductDtoToProduct(CreateProductDto createProductDTO, @MappingTarget Product product);

    default String map(Product product) {
        return product != null ? product.getCategory().getCatId() : null;
    }

    @Mapping(target = "category.catId", source = "catId")
    Product updateProductDtoToProduct(UpdateProductDto updateProductDto, @MappingTarget Product product);
}