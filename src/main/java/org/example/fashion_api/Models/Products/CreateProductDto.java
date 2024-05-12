package org.example.fashion_api.Models.Products;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Data
public class CreateProductDto {
    @NotNull
    private String productId;

    @NotNull
    private String productName;

    @NotNull
    private Long price;

    private Long discountPrice;

    @NotNull
    private String brand;

    private String description;

    @NotNull
    private String imageChooseSize;


    @NotNull
    private String catId;

}
