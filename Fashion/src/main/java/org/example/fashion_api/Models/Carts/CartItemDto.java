package org.example.fashion_api.Models.Carts;


import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor // Thêm constructor mặc định
@AllArgsConstructor
public class CartItemDto {
    private Long id;
    private Integer quantity;


}
