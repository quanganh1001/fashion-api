package org.example.fashion_api.Models.ImgProduct;

import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Data
public class ImgProductDTO {
    private String fileImg;
    private String productId;

}
