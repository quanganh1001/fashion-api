package org.example.fashion_api.Models.Product;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateProductDto {

    @NotNull
    private String productId;

    @NotNull
    private String productName;

    @NotNull
    private Integer price;

    private Integer discountPrice;

    private String brand;

    private String description;

    @NotNull
    private String imageChooseSize;

    @NotNull
    private String catId;

    @NotNull
    private Boolean isProductActive;
}
