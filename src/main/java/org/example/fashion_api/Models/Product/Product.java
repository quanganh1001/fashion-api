package org.example.fashion_api.Models.Product;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnum;
import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.ImgProduct.ImgProduct;
import org.example.fashion_api.Models.ProductDetail.ProductDetail;
import org.example.fashion_api.Services.RedisService.RedisService;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "products")
@NoArgsConstructor(force = true)
@RequiredArgsConstructor
@AllArgsConstructor
@Builder
public class Product   {
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

    @Enumerated(EnumType.STRING)
    private ImgSizeEnum imageChooseSize;

    private Boolean isProductActive;

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE,orphanRemoval = true,fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<ImgProduct> imgProducts;

    @OneToMany(mappedBy = "product",
            orphanRemoval = true,
            cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<ProductDetail> productDetails;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cat_id")
    private Category category;

    @PrePersist
    public void prePersist() {
        if (isProductActive == null)
            isProductActive = true;
    }

    @Transient
    @ToString.Exclude
    final private RedisService redisService;

    @PostPersist
    public void postPersist( ){
        assert redisService != null;
        redisService.clear();
    }

    @PostUpdate
    public void postUpdate( ){
        assert redisService != null;
        redisService.clear();
    }

    @PostRemove
    public void postRemove( ){
        assert redisService != null;
        redisService.clear();
    }

//    @Override
//    public String toString() {
//        return "Product{" +
//                "productId='" + productId + '\'' +
//                ", productName='" + productName + '\'' +
//                ", price=" + price +
//                ", discountPrice=" + discountPrice +
//                ", discountPercent=" + discountPercent +
//                ", isDiscount=" + isDiscount +
//                ", brand='" + brand + '\'' +
//                ", description='" + description + '\'' +
//                ", totalSize=" + totalSize +
//                ", totalColor=" + totalColor +
//                ", imageBackground='" + imageBackground + '\'' +
//                ", imageChooseSize=" + imageChooseSize +
//                ", isProductActive=" + isProductActive +
//                '}';
//    }
}

