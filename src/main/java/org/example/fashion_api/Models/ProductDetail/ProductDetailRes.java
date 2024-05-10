package org.example.fashion_api.Models.ProductDetail;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Enum.SizeEnum;
import org.example.fashion_api.Models.Color.Color;
import org.example.fashion_api.Models.Product.Product;
import org.example.fashion_api.Models.Product.ProductRes;

import java.io.Serializable;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetailRes {
    private Long productDetailId;

    private String code;

    private Integer quantity;

    private Boolean productDetailActive;

    @Enumerated(EnumType.STRING)
    private SizeEnum size;


    private Color color;
}
