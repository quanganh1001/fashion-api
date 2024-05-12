package org.example.fashion_api.Models.Products;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Models.Categories.Category;
import org.example.fashion_api.Models.ImgsProducts.ImgProduct;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Models.RedisListener;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "products")
@NoArgsConstructor(force = true)
@AllArgsConstructor
@Builder
@EntityListeners(RedisListener.class)
public class Product {
    @Id
    private String productId;

    private String productName;

    private Long price;

    private Long discountPrice;

    private Integer discountPercent;

    private String brand;

    private String description;

    private Integer totalSize;

    private Integer totalColor;

    private String imageBackground;

    @Enumerated(EnumType.STRING)
    private ImgSizeEnum imageChooseSize;

    private Boolean isProductActive;

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE, orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<ImgProduct> imgProducts;

    @OneToMany(mappedBy = "product",
            orphanRemoval = true,
            cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<ProductDetail> productsDetails = new ArrayList<>();


    @ManyToOne()
    @JoinColumn(name = "cat_id")
    private Category category;

    @PrePersist
    public void prePersist() {
        if (isProductActive == null)
            isProductActive = true;
    }



}

