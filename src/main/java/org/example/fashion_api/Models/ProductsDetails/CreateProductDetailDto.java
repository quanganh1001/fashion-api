package org.example.fashion_api.Models.ProductsDetails;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateProductDetailDto {

    @NotNull
    private String code;

    @NotNull
    private Integer quantity;

    @NotNull
    private String size;

    @NotNull
    private String productId;

    @NotNull
    private String colorId;
}
