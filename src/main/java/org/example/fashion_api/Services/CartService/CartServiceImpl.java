package org.example.fashion_api.Services.CartService;

import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.ProductDetailMapper;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.CartItem;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Repositories.CartRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private AccountService accountService;

    @Autowired
    private CartRepo cartRepo;
    @Autowired
    private ProductDetailMapper productDetailMapper;
    @Autowired
    private ProductDetailRepo productDetailRepo;

    @Override
    public List<Map.Entry<ProductDetailRes, Integer>> getCart() {
        Account account = accountService.getAccountFromAuthentication();

        Long accountId = account.getId();

        CartItem cartItem = cartRepo.findById(accountId).orElse(new CartItem(accountId, new HashMap<>()));

        List<Map.Entry<ProductDetailRes, Integer>> productDetailResList = new ArrayList<>();

        if (cartItem.getItems() != null) {
            for (Map.Entry<Long, Integer> entry : cartItem.getItems().entrySet()) {
                Long productDetailId = entry.getKey();
                Integer quantity = entry.getValue();

                ProductDetailRes productDetailRes = productDetailMapper.productDetailToProductDetailRes(productDetailRepo.findById(productDetailId).orElseThrow(() -> new NotFoundException("Product detail not found")));

                productDetailResList.add(new AbstractMap.SimpleEntry<>(productDetailRes, quantity));
            }
        }

        return productDetailResList;

    }

    @Override
    public void addCart(Long productDetailId) {
        Account account = accountService.getAccountFromAuthentication();

        Long accountId = account.getId();

        CartItem cartItem = cartRepo.findById(accountId).orElse(new CartItem(accountId, new HashMap<>()));

        cartItem.getItems().put(productDetailId,1);

        cartRepo.save(cartItem);
    }

    @Override
    public void updateCart(Long productDetailId, Integer quantity) {
        Account account = accountService.getAccountFromAuthentication();

        Long accountId = account.getId();

        CartItem cartItem = cartRepo.findById(accountId).orElse(CartItem.builder().id(accountId).items(new HashMap<>()).build());

        if (cartItem.getItems().containsKey(productDetailId)) {
            cartItem.getItems().put(productDetailId, quantity);
            cartRepo.save(cartItem);
        }

    }

    @Override
    public void removeCart(Long productDetailId) {
        Account account = accountService.getAccountFromAuthentication();

        Long accountId = account.getId();

        CartItem cartItem = cartRepo.findById(accountId).orElseThrow();

        cartItem.getItems().remove(productDetailId);

        cartRepo.save(cartItem);
    }

}
