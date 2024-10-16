package org.example.fashion_api.Models.Carts;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;

@Getter
@Setter
@Builder
public class CartItemRes {

    private ProductDetailRes productDetail;

    private Integer quantity;

    private Long totalPriceItem;
}
