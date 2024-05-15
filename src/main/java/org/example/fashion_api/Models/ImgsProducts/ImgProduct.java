package org.example.fashion_api.Models.ImgsProducts;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.Products.Product;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "imgs_product")
public class ImgProduct extends BaseEntity {

    private String fileImg;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;
}
