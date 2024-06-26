package org.example.fashion_api.Mapper;

import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Colors.ColorRes;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ColorMapper {

    List<ColorRes> toDtoList(List<Color> colors);

    Color colorDtoToColor(ColorDto colorDto);

    ColorRes colorToColorRes(Color color);
}
