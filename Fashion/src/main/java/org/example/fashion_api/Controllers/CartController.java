package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Carts.CartItemDto;
import org.example.fashion_api.Models.Carts.CartItemRes;
import org.example.fashion_api.Services.CartService.CartService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/carts")
public class CartController {
    private final CartService cartService;


    @GetMapping("/get")
    @Operation(summary = "get all cart items")
    public ResponseEntity<List<CartItemRes>> getCart() {
        return ResponseEntity.ok(cartService.getCart());
    }

    @GetMapping("/getTotal")
    @Operation(summary = "get total items in cart")
    public ResponseEntity<Integer> getTotalCart() {
        return ResponseEntity.ok(cartService.getTotalItems());
    }

    @PostMapping("/add")
    @Operation(summary = "add item to cart")
    public ResponseEntity<List<CartItemRes>> addCart(@RequestParam Long productDetailId,@RequestParam Integer quantity) {
        cartService.addCart(productDetailId,quantity);
        return ResponseEntity.ok(cartService.getCart());
    }

    @PutMapping("/update")
    @Operation(summary = "change quantity")
    public ResponseEntity<List<CartItemRes>> updateCart(@RequestParam Long productDetailId,@RequestParam Integer quantity) {
        cartService.updateCart(productDetailId,quantity);
        return ResponseEntity.ok(cartService.getCart());
    }

    @DeleteMapping("/remove")
    @Operation(summary = "remove 1 item in cart")
    public ResponseEntity<List<CartItemRes>> removeCart(@RequestParam Long productDetailId) {
        cartService.removeCart(productDetailId);
        return ResponseEntity.ok(cartService.getCart());
    }

    @DeleteMapping("/clear")
    @Operation(summary = "clear cart")
    public ResponseEntity<List<CartItemRes>> clearCart() {
        cartService.clearCart();
        return ResponseEntity.ok(cartService.getCart());
    }

    @PutMapping("/updateCartFromLocalToRedis")
    @Operation(summary = "update cart from local to redis")
    public ResponseEntity<Void> updateCartFromLocalToRedis(@RequestBody List<CartItemDto> listCartJson) {
        cartService.updateCartFromLocalToRedis(listCartJson);
        return ResponseEntity.ok().build();
    }
}
