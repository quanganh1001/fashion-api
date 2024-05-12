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

    private String productId;

    private String productName;

    private Long price;

    private Long discountPrice;

    private Long discountPercent;

    private Boolean isDiscount;

    private String brand;

    private String description;

    private String imageBackground;

    @Enumerated(EnumType.STRING)
    private ImgSizeEnum imageChooseSize;

    private String catId;

    private Integer totalSize;

    private Integer totalColor;

    private Boolean isProductActive;

    private List<ProductDetailRes> productsDetails;
}
