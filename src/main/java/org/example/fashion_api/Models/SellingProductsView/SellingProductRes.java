package org.example.fashion_api.Models.SellingProductsView;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Builder
public class SellingProductRes {
    private long id;

    private String productName;

    private long price;

    private Long discountPrice;

    private Long discountPercent;

    private int totalSize;

    private int totalColor;

    private String imageBackground;

    private Integer totalQuantitySold;

    private Long totalSales;
}
