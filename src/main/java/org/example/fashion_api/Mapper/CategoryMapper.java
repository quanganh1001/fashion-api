package org.example.fashion_api.Mapper;
import org.example.fashion_api.Models.Categories.Category;
import org.example.fashion_api.Models.Categories.CategoryDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;


import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CategoryMapper {



    @Mapping(target = "catParent.catId", source = "catParent")
    Category categoryDtoToCategory(CategoryDto categoryDto, @MappingTarget Category category);

    CategoryDto categoryToCategoryDto(Category category);

    List<CategoryDto> toDtoList(List<Category> categories);

    default String map(Category category) {
        return category != null ? category.getCatId() : null;
    }

}