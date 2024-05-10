package org.example.fashion_api.Models.Products;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PageProductRes {

    private List<ProductRes> productsRes;

    private int totalPages;

    private Long totalProduct;

    private int currenPage;

}
