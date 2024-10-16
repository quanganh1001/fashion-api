package org.example.fashion_api.Controllers;


import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.ImgsProducts.ImgProductRes;
import org.example.fashion_api.Services.ImgProductService.ImgProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/imgProducts")
public class ImageProductController {

    private final ImgProductService imgProductService;


    @Operation(summary = "delete image (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{imgProductId}")
    public ResponseEntity<String> deleteImgProductById(@PathVariable Long imgProductId) throws IOException {
        imgProductService.deleteImgProduct(imgProductId);
        return ResponseEntity.ok("Deleted image product with id " + imgProductId);
    }
}
