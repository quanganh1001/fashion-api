package org.example.fashion_api.Models.ImgProduct;

import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;
import org.example.fashion_api.Models.Product.Product;

@Data
public class ImgProductDTO {

    private String fileImg;
    
    private Product productId;

}
