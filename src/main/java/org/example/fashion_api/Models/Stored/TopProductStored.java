package org.example.fashion_api.Models.Stored;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.example.fashion_api.Models.BaseEntity;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "top_products")
public class TopProductStored extends BaseEntity {
    private String imageBackground;
    private String productName;
    private Long product_detail_id;
    private String size;
    private String colorName;
    private Double totalSales;
    private Integer totalQuantitySold;
    private LocalDate confirmationDate;
}