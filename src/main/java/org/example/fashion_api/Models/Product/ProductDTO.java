package org.example.fashion_api.Models.Product;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.ImgProduct.ImgProduct;

import java.util.List;

@Data
public class ProductDTO {
    private String productName;
    private Integer price;
    private Integer discountPrice;
    private String brand;
    private String description;
    private String imageBackground;
    private String imageChooseSize;
    private Boolean isProductActive;
    private Integer catId;

}
