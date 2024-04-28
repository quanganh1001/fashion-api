package org.example.fashion_api.Models.ProductDetail;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Enum.SizeEnum;
import org.example.fashion_api.Models.Color.Color;
import org.example.fashion_api.Models.Product.Product;

import java.io.Serializable;

@Getter
@Setter
@Builder
public class ProductDetailRes {

    @NotNull
    private String code;

    @NotNull
    private Integer quantity;

    @NotNull
    private Boolean productDetailActive;

    @Enumerated(EnumType.STRING)
    private SizeEnum size;

    @NotNull
    private Product product;

    @NotNull
    private Color color;
}
