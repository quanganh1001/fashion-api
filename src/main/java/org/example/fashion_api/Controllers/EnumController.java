package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import org.example.fashion_api.Enum.EnumDto;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Enum.SizeEnum;
import org.hibernate.engine.jdbc.Size;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("enums")
public class EnumController {

    @Operation(summary = "get Enum size image ")
    @GetMapping("sizeImage")
    public ResponseEntity<List<EnumDto>> sizeImage(){
        List<EnumDto> enumDtos = new ArrayList<>();
        for (ImgSizeEnum imgSizeEnum : ImgSizeEnum.values()) {
            enumDtos.add(new EnumDto(imgSizeEnum.name(),imgSizeEnum.getName()));
        }
        return ResponseEntity.ok(enumDtos);
    }

    @Operation(summary = "get Enum size ")
    @GetMapping("size")
    public ResponseEntity<List<EnumDto>> size(){
        List<EnumDto> enumDtos = new ArrayList<>();
        for (SizeEnum imgSizeEnum : SizeEnum.values()) {
            enumDtos.add(new EnumDto(imgSizeEnum.name(), imgSizeEnum.getSize()));
        }
        return ResponseEntity.ok(enumDtos);
    }
}
