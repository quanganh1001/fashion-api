package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import org.example.fashion_api.Enum.*;
import org.hibernate.engine.jdbc.Size;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("enums")
public class EnumController {

    @Operation(summary = "get Enum size image ")
    @GetMapping("sizeImages")
    @PreAuthorize("hasAnyRole('MANAGER')")
    public ResponseEntity<List<EnumDto>> sizeImage(){
        List<EnumDto> enumDtos = new ArrayList<>();
        for (ImgSizeEnum imgSizeEnum : ImgSizeEnum.values()) {
            enumDtos.add(new EnumDto(imgSizeEnum.name(),imgSizeEnum.getKey()));
        }
        return ResponseEntity.ok(enumDtos);
    }

    @Operation(summary = "get Enum size ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @GetMapping("sizes")
    public ResponseEntity<List<EnumDto>> size(){
        List<EnumDto> enumDtos = new ArrayList<>();
        for (SizeEnum imgSizeEnum : SizeEnum.values()) {
            enumDtos.add(new EnumDto(imgSizeEnum.name(), imgSizeEnum.getSize()));
        }
        return ResponseEntity.ok(enumDtos);
    }

    @Operation(summary = "get Role ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @GetMapping("roles")
    public ResponseEntity<List<EnumDto>> role(){
        List<EnumDto> enumDtos = new ArrayList<>();
        for (RoleEnum roleEnum : RoleEnum.values()) {
            enumDtos.add(new EnumDto(roleEnum.name(), roleEnum.getRole()));
        }
        return ResponseEntity.ok(enumDtos);
    }

    @GetMapping("/getUrlImgEnum")
    public ResponseEntity<String> getUrlImgEnum(@RequestParam String ImgEnum) {
        ImgSizeEnum imgSizeEnum = ImgSizeEnum.fromKey(ImgEnum);
        if (imgSizeEnum != null) {
            return ResponseEntity.ok(imgSizeEnum.getValue());
        } else {
            return ResponseEntity.badRequest().body("Invalid ImgEnum value: " + ImgEnum);
        }
    }

    @Operation(summary = "get invoice status ")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("invoiceStatus")
    public ResponseEntity<List<EnumDto>> invoiceStatus(){
        List<EnumDto> enumDtos = new ArrayList<>();
        for (InvoiceStatusEnum statusEnum : InvoiceStatusEnum.values()) {
            enumDtos.add(new EnumDto(statusEnum.name(), statusEnum.getDes()));
        }
        return ResponseEntity.ok(enumDtos);
    }
}
