package org.example.fashion_api.Controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Models.ImgsProducts.ImgProduct;
import org.example.fashion_api.Models.ImgsProducts.ImgProductRes;
import org.example.fashion_api.Models.Products.CreateProductDto;
import org.example.fashion_api.Models.Products.PageProductRes;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.Products.UpdateProductDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Models.SellingProductsView.SellingProductsView;
import org.example.fashion_api.Services.ImgProductService.ImgProductService;
import org.example.fashion_api.Services.ProductDetailService.ProductDetailService;
import org.example.fashion_api.Services.ProductService.ProductService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.example.fashion_api.Services.SellingProductsViewService.SellingProductsViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;
    private final ProductDetailService productDetailService;
    private final ImgProductService imgProductService;
    private final SellingProductsViewService sellingProductsViewService;

    @Operation(summary = "get all products ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @GetMapping()
    public ResponseEntity<PageProductRes> getAllProducts(@RequestParam(defaultValue = "",required = false) String keyword,
                                         @RequestParam(defaultValue = "1") int page,
                                         @RequestParam(defaultValue = "10") int limit) throws JsonProcessingException {
        return ResponseEntity.ok(productService.getAllProducts(keyword,page-1,limit));
    }

    @Operation(summary = "get product for admin page")
    @GetMapping("/{productId}")
    public ResponseEntity<ProductRes> getProductAdmin(@PathVariable("productId") Long productId){
        return ResponseEntity.ok(productService.getProductForAdminPage(productId));
    }

    @Operation(summary = "get product for client page")
    @GetMapping("/client/{productId}")
    public ResponseEntity<ProductRes> getProductClient(@PathVariable("productId") Long productId){
        return ResponseEntity.ok(productService.getProductForClientPage(productId));
    }

    @Operation(summary = "get product by catId ")
    @GetMapping("/getByCategory/{catId}")
    public ResponseEntity<List<ProductRes>> getProductsByCategory(@RequestParam(defaultValue = "")String keyword,
                                                @PathVariable String catId) throws JsonProcessingException {
        return ResponseEntity.ok(productService.getAllProductsByCategory(keyword,catId));
    }

    @Operation(summary = "create product (role MANAGER) ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping()
    public ResponseEntity<ProductRes> addProduct(@Valid @RequestBody CreateProductDto createProductDTO){
        return ResponseEntity.ok(productService.addProduct(createProductDTO));
    }

    @Operation(summary = "update product (role MANAGER) ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PutMapping("/{productId}")
    public ResponseEntity<ProductRes> updateProduct(@Valid @RequestBody UpdateProductDto updateProductDto,
                                    @PathVariable Long productId) {
        return ResponseEntity.ok(productService.updateProduct(productId, updateProductDto));
    }

    @Operation(summary = "delete product (role MANAGER) ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{productId}")
    public ResponseEntity<String> deleteProduct(@PathVariable Long productId){
        productService.deleteProduct(productId);
        return ResponseEntity.ok("deleted");
    }


    @Operation(summary = "update image background product (role MANAGER) ")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PutMapping("/{productId}/updateProductBackground")
    public ResponseEntity<String> updateProductBackground(@RequestBody String imageUrl, @PathVariable("productId") Long productId) throws IOException {
        return productService.updateProductBackground(imageUrl,productId);

    }

    @Operation(summary = "get product detail by productId")
    @GetMapping("/{productId}/productsDetail")
    public ResponseEntity<List<ProductDetailRes>> getAllProductDetailsByProductId(@PathVariable("productId") Long productId) throws JsonProcessingException {
        return ResponseEntity.ok(productDetailService.findAllProductDetails(productId));
    }

    @Operation(summary = "get image by productId")
    @GetMapping("/{productId}/images")
    public ResponseEntity<List<ImgProductRes>> getImgProductsByProductId(@PathVariable Long productId) {
        return ResponseEntity.ok(imgProductService.imgProductByProductId(productId));
    }

    @Operation(summary = "create image (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @PostMapping("/{productId}/createImage")
    public ResponseEntity<String> addImgProduct(@PathVariable Long productId, MultipartFile[] imgFiles) throws IOException {
        imgProductService.createImgProduct(productId, imgFiles);
        return ResponseEntity.ok("done");
    }

    @Operation(summary = "Get best selling products")
    @GetMapping("/selectListProducts")
    public ResponseEntity<List<ProductRes>> selectListProducts(@RequestParam String selected) throws JsonProcessingException {
        return ResponseEntity.ok(sellingProductsViewService.selectListProducts(selected));
    }


}
