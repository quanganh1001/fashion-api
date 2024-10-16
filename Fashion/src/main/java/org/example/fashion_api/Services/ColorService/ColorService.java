package org.example.fashion_api.Services.ColorService;

import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Colors.ColorRes;

import java.util.List;

public interface ColorService {
    List<ColorRes> findAll();

    ColorRes createColor(ColorDto colorDto);

    void deleteColor(Long colorId);
}
