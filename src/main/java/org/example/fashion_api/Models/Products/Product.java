package org.example.fashion_api.Models.Products;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Models.BaseEntity;
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
public class Product extends BaseEntity {

    @NotNull
    private String productCode;

    @NotNull
    private String productName;

    @NotNull
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

    @NotNull
    private Boolean isActivated = Boolean.TRUE;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<ImgProduct> imgProducts;

    @OneToMany(mappedBy = "product",
            cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<ProductDetail> productsDetails = new ArrayList<>();


    @ManyToOne()
    @JoinColumn(name = "cat_id")
    private Category category;


}

