package org.example.fashion_api.Models.ProductDetail;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateProductDetailDto {

    @NotNull
    private String code;

    @NotNull
    private Integer quantity;

    @NotNull
    private Boolean productDetailActive;

    @NotNull
    private String size;

    @NotNull
    private String productId;

    @NotNull
    private String colorId;
}
