package org.example.fashion_api.Models.Products;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnum;

@Data
public class CreateProductDto {

    @NotNull
    private String productCode;

    @NotNull
    private String productName;

    @NotNull
    private Long price;

    private Long discountPrice;

    @NotNull
    private String brand;

    private String description;

    @NotNull
    private ImgSizeEnum imageChooseSize;

    @NotNull
    private String catId;

}
