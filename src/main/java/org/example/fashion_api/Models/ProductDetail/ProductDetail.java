package org.example.fashion_api.Models.ProductDetail;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.SizeEnum;
import org.example.fashion_api.Models.Color.Color;
import org.example.fashion_api.Models.Product.Product;
import org.example.fashion_api.Models.RedisListener;
import org.example.fashion_api.Services.RedisService.RedisService;

@AllArgsConstructor
@NoArgsConstructor(force = true)
@Builder
@Entity
@Data
@EntityListeners(RedisListener.class)
@Table(name = "products_detail")
public class ProductDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long productDetailId;

    private String code;

    private Integer quantity;

    private Boolean outOfStock;

    private Boolean productDetailActive;

    @NotNull
    @Enumerated(EnumType.STRING)
    private SizeEnum size;

    @ManyToOne()
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
