package org.example.fashion_api.Models.ProductsDetails;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.SizeEnum;

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
    private Long colorId;

    @NotNull
    private SizeEnum size;

    @NotNull
    private Boolean isActivated;

}
