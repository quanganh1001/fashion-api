package org.example.fashion_api.Models.Product;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnum;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductRes {

    private String productId;

    private String productName;

    private Integer price;

    private Integer discountPrice;

    private Integer discountPercent;

    private Boolean isDiscount;

    private String brand;

    private String description;

    private String imageBackground;

    @Enumerated(EnumType.STRING)
    private ImgSizeEnum imageChooseSize;

    private String catId;

    private Integer totalSize;

    private Integer totalColor;

    private Boolean isProductActive;
}