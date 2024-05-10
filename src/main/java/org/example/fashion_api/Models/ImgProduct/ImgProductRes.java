package org.example.fashion_api.Models.ImgProduct;

import lombok.Data;
import org.example.fashion_api.Models.Product.Product;

@Data
public class ImgProductRes {

    private Long imgId;

    private String fileImg;
    
    private Product productId;

}
