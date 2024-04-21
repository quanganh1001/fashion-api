package org.example.fashion_api.Models.ProductDetail;

import jakarta.persistence.*;
import lombok.Data;
import org.example.fashion_api.Models.Color.Color;
import org.example.fashion_api.Models.Product.Product;

@Entity
@Data
@Table(name = "products_detail")
public class ProductDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productDetailId;
    private String code;
    private Integer quantity;
    private Boolean outOfStock;
    private Boolean productDetailActive;
    private String size;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "color_id")
    private Color color;

    @PrePersist
    public void prePersist() {
        if (productDetailActive == null)
            productDetailActive = true;
    }
}
