package org.example.fashion_api.Models.ProductsDetails;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Enum.SizeEnum;
import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Products.ProductRes;

@Getter
@Setter
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDetailRes {
    private Long id;

    private String code;

    private Integer quantity;

    private Boolean isActivated;

    @Enumerated(EnumType.STRING)
    private SizeEnum size;

    private String color;

    private Long colorId;

    private String productName;

    private Long price;

    private Long discountPrice;

    private int discountPercent;

    private String imageBackground;

}
