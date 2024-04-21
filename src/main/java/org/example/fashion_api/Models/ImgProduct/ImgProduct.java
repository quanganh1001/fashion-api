package org.example.fashion_api.Models.ImgProduct;

import jakarta.persistence.*;
import lombok.Data;
import project.model.Product.Product;

@Data
@Entity
@Table(name = "imgs_product")
public class ImgProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer imgId;

    private String fileImg;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
}
