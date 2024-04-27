package org.example.fashion_api.Models.Product;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnumDTO;
import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.ImgProduct.ImgProduct;
import org.example.fashion_api.Models.ProductDetail.ProductDetail;

import java.util.List;

@Entity
@Data
@Table(name = "products")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {
    @Id
    private String productId;

    private String productName;

    private Integer price;

    private Integer discountPrice;

    private Integer discountPercent;

    private Boolean isDiscount;

    private String brand;

    private String description;

    private Integer totalSize;

    private Integer totalColor;

    private String imageBackground;

    private String imageChooseSize;

    private Boolean isProductActive;

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<ImgProduct> imgProducts;

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<ProductDetail> productDetails;


    @ManyToOne
    @JoinColumn(name = "cat_id")
    private Category category;

    @PrePersist
    public void prePersist() {
        if (isProductActive == null)
            isProductActive = true;
    }

}

