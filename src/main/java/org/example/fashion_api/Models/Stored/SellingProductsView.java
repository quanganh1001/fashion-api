package org.example.fashion_api.Models.Stored;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "selling_products")
public class SellingProductsView extends BaseEntity {

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
