package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import org.example.fashion_api.Models.CartItem;
import org.example.fashion_api.Services.CartService.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/carts")
public class CartController {
    @Autowired
    private CartService cartService;

    @PostMapping("/add")
    public ResponseEntity<String> addCart(@RequestParam Long productDetailId,@RequestParam int quantity) {
        cartService.addCart(productDetailId,quantity);
        return ResponseEntity.ok("Added cart successfully");
    }

    @DeleteMapping("/remove")
    public ResponseEntity<String> addCart(@RequestParam Long productDetailId) {
        cartService.removeCart(productDetailId);
        return ResponseEntity.ok("Removing cart successfully");
    }
}
