package org.example.fashion_api.Models.Products;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductRes {
    private Long id;

    private String productCode;

    private String productName;

    private Long price;

    private Long discountPrice;

    private Long discountPercent;

    private String brand;

    private String description;

    private String imageBackground;

    @Enumerated(EnumType.STRING)
    private ImgSizeEnum imageChooseSize;

    private String catName;

    private Integer totalSize;

    private Integer totalColor;

    private Boolean isActivated;

    private List<ProductDetailRes> productsDetails;
}
