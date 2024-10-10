package org.example.fashion_api.Services.CartService;

import org.example.fashion_api.Models.Carts.CartItemRes;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;

import java.util.List;
import java.util.Map;

public interface CartService {

    List<CartItemRes> getCart();

    void addCart(Long productDetailId,Integer quantity);

    void updateCart(Long productDetailId, Integer quantity);

    void removeCart(Long productDetailId);

    Integer getTotalItems();

    void clearCart();
}