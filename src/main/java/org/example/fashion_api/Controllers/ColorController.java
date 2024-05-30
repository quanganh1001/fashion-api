package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Colors.ColorRes;
import org.example.fashion_api.Services.ColorService.ColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("colors")
public class ColorController {
    @Autowired
    private ColorService colorService;

    @Operation(summary = "get all colors (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @GetMapping()
    public List<ColorRes> findAll(){
        return colorService.findAll();
    }

    @Operation(summary = "create color (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping()
    public ColorRes createColor(@Valid @RequestBody ColorDto colorDto){
        return colorService.createColor(colorDto);
    }

    @Operation(summary = "delete color (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{colorId}")
    public ResponseEntity<String> deleteColor(@PathVariable Long colorId){
        colorService.deleteColor(colorId);
        return ResponseEntity.ok("Deleted");
    }
}
