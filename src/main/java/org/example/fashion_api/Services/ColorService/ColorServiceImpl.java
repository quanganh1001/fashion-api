package org.example.fashion_api.Services.ColorService;

import jakarta.validation.Valid;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Mapper.ColorMapper;
import org.example.fashion_api.Models.Colors.ColorRes;
import org.example.fashion_api.Repositories.ColorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ColorServiceImpl implements ColorService {
    @Autowired
    private ColorRepo colorRepo;
    @Autowired
    private ColorMapper colorMapper;

    @Override
    public List<ColorRes> findAll(){
        return colorMapper.toDtoList(colorRepo.findAll());
    }

    @Override
    public ColorRes createColor(@Valid ColorDto colorDto){

        // check exist by color code
        if (colorRepo.existsByColorCode(colorDto.getColorCode())){
            throw new AlreadyExistException(colorDto.getColorCode());
        }

        Color color = colorRepo.save(colorMapper.colorDtoToColor(colorDto));

        return colorMapper.colorToColorRes(color);
    }

    @Override
    public void deleteColor(Long colorId){
        Color color = colorRepo.findById(colorId).orElseThrow(()-> new NotFoundException("color"));
        colorRepo.delete(color);
    }
}
