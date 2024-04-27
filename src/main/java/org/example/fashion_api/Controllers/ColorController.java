package org.example.fashion_api.Controllers;

import jakarta.validation.Valid;
import org.example.fashion_api.Models.Color.ColorDto;
import org.example.fashion_api.Services.ColorService.ColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("colors")
public class ColorController {
    @Autowired
    private ColorService colorService;

    @GetMapping()
    public List<ColorDto> findAll(){
        return colorService.findAll();
    }

    @PostMapping()
    public ColorDto createColor(@Valid @RequestBody ColorDto colorDto){
        return colorService.createColor(colorDto);
    }

    @DeleteMapping("/{colorId}")
    public ResponseEntity<String> deleteColor(@PathVariable String colorId){
        colorService.deleteColor(colorId);
        return ResponseEntity.ok("Deleted");
    }
}
