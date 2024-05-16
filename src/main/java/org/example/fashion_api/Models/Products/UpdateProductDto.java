package org.example.fashion_api.Models.Products;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateProductDto  {

    @NotNull
    private String productCode;

    @NotNull
    private String productName;

    @NotNull
    private Long price;

    private Long discountPrice;

    private String brand;

    private String description;

    @NotNull
    private String imageChooseSize;

    @NotNull
    private Boolean isActivated;
}
