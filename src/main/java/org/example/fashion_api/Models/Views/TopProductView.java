package org.example.fashion_api.Models.Views;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.example.fashion_api.Models.BaseEntity;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "top_products")
public class TopProductView extends BaseEntity {
    private String imageBackground;
    private String productName;
    private Long productId;
    private String size;
    private String colorName;
    private Double totalSales;
    private Integer totalQuantitySold;
}