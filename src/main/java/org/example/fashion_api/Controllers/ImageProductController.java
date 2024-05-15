package org.example.fashion_api.Controllers;


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
@RequestMapping("/imgProducts")
public class ImageProductController {
    @Autowired
    private ImgProductService imgProductService;


    @GetMapping("/{productId}")
    public List<ImgProductRes> getImgProductsByProductId(@PathVariable Long productId) {
        return imgProductService.imgProductByProductId(productId);
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping("/{productId}")
    public ResponseEntity<String> addImgProduct(@PathVariable Long productId, MultipartFile[] imgFiles) throws IOException {
        imgProductService.createImgProduct(productId, imgFiles);
        return ResponseEntity.ok("done");
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{imgProductId}")
    public ResponseEntity<String> deleteImgProductById(@PathVariable Long imgProductId) throws IOException {
        imgProductService.deleteImgProduct(imgProductId);
        return ResponseEntity.ok("Deleted image product with id " + imgProductId);
    }
}
