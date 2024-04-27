package org.example.fashion_api.Services.ColorService;

import org.example.fashion_api.Models.Color.ColorDto;

import java.util.List;

public interface ColorService {
    List<ColorDto> findAll();

    ColorDto createColor(ColorDto colorDto);

    void deleteColor(String colorId);
}
