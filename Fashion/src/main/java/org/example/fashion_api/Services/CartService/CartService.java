package org.example.fashion_api.Services.CartService;

import org.example.fashion_api.Models.Carts.CartItemDto;
import org.example.fashion_api.Models.Carts.CartItemRes;

import java.util.List;

public interface CartService {

    List<CartItemRes> getCart();

    void addCart(Long productDetailId,Integer quantity);

    void updateCart(Long productDetailId, Integer quantity);

    void removeCart(Long productDetailId);

    Integer getTotalItems();

    void clearCart();

    void updateCartFromLocalToRedis(List<CartItemDto> listCart);
}