package org.example.fashion_api.Services.CartService;

import org.example.fashion_api.Models.CartItem;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CartService {

    List<Map.Entry<ProductDetailRes, Integer>> getCart();

    void addCart(Long productDetailId);

    void updateCart(Long productDetailId, Integer quantity);

    void removeCart(Long productDetailId);
}