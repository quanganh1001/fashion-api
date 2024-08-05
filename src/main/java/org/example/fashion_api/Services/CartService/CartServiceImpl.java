package org.example.fashion_api.Services.CartService;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Mapper.ProductDetailMapper;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.Carts.CartItem;
import org.example.fashion_api.Models.Carts.CartItemRes;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Repositories.CartRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

    private final AccountService accountService;
    private final CartRepo cartRepo;
    private final ProductDetailMapper productDetailMapper;
    private final ProductDetailRepo productDetailRepo;

    @Override
    public List<CartItemRes> getCart() {
        CartItem cartItem = getCartItem();

        List<CartItemRes> cartRes = new ArrayList<>();

        if (cartItem.getItems() != null) {
            for (Map.Entry<Long, Integer> entry : cartItem.getItems().entrySet()) {
                ProductDetailRes productDetailRes =
                        productDetailMapper.productDetailToProductDetailRes(
                                productDetailRepo.findById(entry.getKey()).orElseThrow()
                        );

                var price = (productDetailRes.getDiscountPrice() != null ? productDetailRes.getDiscountPrice() :
                        productDetailRes.getPrice());
                cartRes.add(
                        CartItemRes.builder().
                                productDetail(productDetailRes)
                                .quantity(entry.getValue())
                                .totalPriceItem(price * entry.getValue())
                                .build()
                );
            }
        }

        return cartRes;

    }

    @Override
    public void addCart(Long productDetailId,Integer quantity) {
        CartItem cartItem = getCartItem();

        if (cartItem.getItems() == null) {
            cartItem.setItems(new HashMap<>());
        }

        if (cartItem.getItems().containsKey(productDetailId)) {
            cartItem.getItems().put(productDetailId, cartItem.getItems().get(productDetailId) + quantity);
        }else {
            cartItem.getItems().put(productDetailId,quantity);
        }


        cartRepo.save(cartItem);

    }

    @Override
    public void updateCart(Long productDetailId, Integer quantity) {
        CartItem cartItem = getCartItem();
        if (cartItem.getItems() == null) {
            cartItem.setItems(new HashMap<>());
        }
            cartItem.getItems().put(productDetailId, quantity);
            cartRepo.save(cartItem);

    }

    @Override
    public void removeCart(Long productDetailId) {
        CartItem cartItem = getCartItem();

        cartItem.getItems().remove(productDetailId);

        cartRepo.save(cartItem);
    }

    @Override
    public Integer getTotalItems() {
        CartItem cartItem = getCartItem();
        if (cartItem.getItems() == null) {
            return 0;
        }

        int totalItems = 0;
        for (Integer quantity : cartItem.getItems().values()) {
            totalItems += quantity;
        }

        return totalItems;
    }

    @Override
    public void clearCart() {
        CartItem cartItem = getCartItem();
        cartItem.setItems(new HashMap<>());
        cartRepo.save(cartItem);
    }

    public CartItem getCartItem() {
        Account account = accountService.getAccountFromAuthentication();

        return cartRepo.findById(account.getId()).orElse(CartItem.builder().id(account.getId()).items(new HashMap<>()).build());
    }
}
