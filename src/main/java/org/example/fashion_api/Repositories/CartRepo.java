package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Carts.CartItem;
import org.springframework.data.repository.ListCrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepo extends ListCrudRepository<CartItem, Long> {



}
