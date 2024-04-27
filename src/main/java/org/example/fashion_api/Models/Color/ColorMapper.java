package org.example.fashion_api.Models.Color;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ColorMapper {

    List<ColorDto> toDtoList(List<Color> colors);

    Color colorDtoToColor(ColorDto colorDto);
}
