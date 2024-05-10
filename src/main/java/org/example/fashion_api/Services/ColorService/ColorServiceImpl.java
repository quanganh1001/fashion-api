package org.example.fashion_api.Services.ColorService;

import jakarta.validation.Valid;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Mapper.ColorMapper;
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
    public List<ColorDto> findAll(){
        return colorMapper.toDtoList(colorRepo.findAll());
    }

    @Override
    public ColorDto createColor(@Valid ColorDto colorDto){
        if (colorRepo.existsById(colorDto.getColorId())){
            throw new AlreadyExistException(colorDto.getColorId());
        }

        Color color = colorMapper.colorDtoToColor(colorDto);

        colorRepo.save(color);

        return colorDto;
    }

    @Override
    public void deleteColor(String colorId){
        Color color = colorRepo.findById(colorId).orElseThrow(()-> new NotFoundException(colorId));
        colorRepo.delete(color);
    }
}
