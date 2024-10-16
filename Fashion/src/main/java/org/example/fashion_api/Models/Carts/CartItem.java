package org.example.fashion_api.Models.Carts;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.redis.core.RedisHash;

import java.util.HashMap;
import java.util.Map;

@RedisHash("carts")
@Data
@Builder
@AllArgsConstructor
public class CartItem {

    @Id
    private Long id;

    Map<Long, Integer> items = new HashMap<>();
}
