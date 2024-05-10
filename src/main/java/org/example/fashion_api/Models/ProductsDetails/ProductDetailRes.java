package org.example.fashion_api.Models.ProductsDetails;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.*;
import org.example.fashion_api.Enum.SizeEnum;
import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Products.ProductRes;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetailRes {
    private Long productDetailId;

    private String code;

    private Integer quantity;

    private Boolean productDetailActive;

    @Enumerated(EnumType.STRING)
    private SizeEnum size;

    private Color color;

    private ProductRes product;

}
