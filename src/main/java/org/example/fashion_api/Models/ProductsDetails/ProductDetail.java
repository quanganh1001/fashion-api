package org.example.fashion_api.Models.ProductsDetails;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.SizeEnum;
import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.RedisListener;

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

    private Boolean isActivated = Boolean.TRUE;

    @NotNull
    @Enumerated(EnumType.STRING)
    private SizeEnum size;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "color_id")
    private Color color;



}
