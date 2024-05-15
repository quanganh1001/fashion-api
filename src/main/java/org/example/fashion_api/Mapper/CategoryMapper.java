package org.example.fashion_api.Mapper;
import org.example.fashion_api.Models.Categories.Category;
import org.example.fashion_api.Models.Categories.CategoryDto;
import org.example.fashion_api.Models.Categories.CategoryRes;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;


import java.util.List;

@Mapper(componentModel = "spring",uses = {ProductMapper.class}, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CategoryMapper {



    @Mapping(target = "catParent.id", source = "catParent")
    Category categoryDtoToCategory(CategoryDto categoryDto, @MappingTarget Category category);

    List<CategoryRes> toDtoList(List<Category> categories);

    @Mapping(target = "catParent",source = "catParent.id")
    CategoryRes categoryToCategoryRes(Category category);

}