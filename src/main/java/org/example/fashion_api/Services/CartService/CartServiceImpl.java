package org.example.fashion_api.Services.CartService;

import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.CartItem;
import org.example.fashion_api.Repositories.CartRepo;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private RedisService redisService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private CartRepo cartRepo;

    @Override
    public void addCart(Long productDetailId, Integer quantity) {

        Account account = accountService.getAccountFromAuthentication();

        Long accountId = account.getId();

        CartItem cartItem = cartRepo.findById(accountId).orElseThrow();

        cartItem.getItems().put(productDetailId, quantity);

        cartRepo.save(cartItem);
    }

    @Override
    public void updateCart(Long productDetailId, Integer quantity) {

    }

    @Override
    public void removeCart(Long productDetailId) {
        Account account = accountService.getAccountFromAuthentication();

        Long accountId = account.getId();

        CartItem cartItem = cartRepo.findById(accountId).orElseThrow();

        cartItem.getItems().clear();
    }

}
