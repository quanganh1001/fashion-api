package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import org.example.fashion_api.Models.CartItem;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Services.CartService.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/carts")
public class CartController {
    @Autowired
    private CartService cartService;


    @GetMapping("/get")
    public ResponseEntity<List<Map.Entry<ProductDetailRes, Integer>>> getCart() {
        return ResponseEntity.ok(cartService.getCart());

    }


    @PostMapping("/add")
    public ResponseEntity<String> addCart(@RequestParam Long productDetailId) {
        cartService.addCart(productDetailId);
        return ResponseEntity.ok("Added cart successfully");
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateCart(@RequestParam Long productDetailId,@RequestParam Integer quantity) {
        cartService.updateCart(productDetailId,quantity);
        return ResponseEntity.ok("Updated cart successfully");
    }

    @DeleteMapping("/remove")
    public ResponseEntity<String> removeCart(@RequestParam Long productDetailId) {
        cartService.removeCart(productDetailId);
        return ResponseEntity.ok("Removing cart successfully");
    }
}
