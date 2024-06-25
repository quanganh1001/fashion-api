package org.example.fashion_api.Services.CartService;

import org.example.fashion_api.Models.CartItem;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;

public interface CartService {

    void addCart(Long productDetailId, Integer quantity);

    void updateCart(Long productDetailId, Integer quantity);

    void removeCart(Long productDetailId);
}