package org.example.fashion_api.Models.ImgsProducts;

import lombok.Data;
import org.example.fashion_api.Models.Products.Product;

@Data
public class ImgProductRes {

    private Long id;

    private String fileImg;
    
    private String productId;

}
