package org.example.fashion_api.Models.Category;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface CategoryMapper {
    CategoryMapper INSTANCE = Mappers.getMapper(CategoryMapper.class);

    @Mapping(target = "catParent.catId", source = "catParent")
    Category categoryDtoToCategory(CategoryDto categoryDto,@MappingTarget Category category);

    CategoryDto categoryToCategoryDto(Category category);

    List<CategoryDto> toDtoList(List<Category> categories);

    default String map(Category category) {
        return category != null ? category.getCatId() : null;
    }
}