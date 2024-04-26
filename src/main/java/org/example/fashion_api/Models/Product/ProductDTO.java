package org.example.fashion_api.Models.Product;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.ImgSizeEnumDTO;
import org.example.fashion_api.Enum.RoleEnumDTO;
import org.example.fashion_api.Models.ImgProduct.ImgProduct;

import java.util.List;

@Data
public class ProductDTO {
    @NotNull
    private String productId;

    @NotNull
    private String productName;

    @NotNull
    private Integer price;

    private Integer discountPrice;

    @NotNull
    private String brand;

    private String description;

    private String imageBackground;

    @NotNull
    private String imageChooseSize;

    @NotNull
    private Boolean isProductActive;

    @NotNull
    private String catId;

}
