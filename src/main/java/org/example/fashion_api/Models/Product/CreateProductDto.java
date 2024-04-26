package org.example.fashion_api.Models.Product;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Data
public class CreateProductDto {
    @NotNull
    private String productId;

    @NotNull
    private String productName;

    @NotNull
    private Integer price;

    private Integer discountPrice;

    @NotNull
    private String brand;

    private String description;

    @NotNull
    private String imageChooseSize;


    @NotNull
    private String catId;

}
