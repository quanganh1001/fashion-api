package org.example.fashion_api.Models.ProductDetail;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.SizeEnum;
import org.example.fashion_api.Models.Color.Color;
import org.example.fashion_api.Models.Product.Product;

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
