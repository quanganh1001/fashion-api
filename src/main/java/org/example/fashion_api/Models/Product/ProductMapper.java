package org.example.fashion_api.Models.Product;

import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ProductMapper {

    List<ProductDTO> toDtoList(List<Product> products);


    @Mapping(target = "catId", source = "category.catId")
    ProductDTO productToProductDto(Product product);


    @Mapping(target = "category.catId", source = "catId")
    Product productDtoToProduct(ProductDTO productDTO, @MappingTarget Product product);

    default String map(Product product) {
        return product != null ? product.getCategory().getCatId() : null;
    }

}
