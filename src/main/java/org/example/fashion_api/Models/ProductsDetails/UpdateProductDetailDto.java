package org.example.fashion_api.Models.ProductsDetails;

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
    private Boolean isActivated;

}
