package org.example.fashion_api.Models.ProductDetail;

import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Data
public class ProductDetailDTO {
    private String code;
    private Integer quantity;
    private Boolean productDetailActive;
    private String size;
    private String productId;
    private String color;
}
