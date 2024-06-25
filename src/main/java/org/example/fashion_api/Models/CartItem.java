package org.example.fashion_api.Models;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Producer.MailProducer;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.index.Indexed;

import java.util.HashMap;
import java.util.List;
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
