package org.example.fashion_api.Services.ColorService;

import org.example.fashion_api.Models.Colors.ColorDto;

import java.util.List;

public interface ColorService {
    List<ColorDto> findAll();

    ColorDto createColor(ColorDto colorDto);

    void deleteColor(Long colorId);
}
