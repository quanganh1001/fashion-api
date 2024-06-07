package org.example.fashion_api.Models.Products;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PageProductRes {

    private int totalPages;

    private int totalProduct;

    private int currentPage;

    private List<ProductRes> productsRes;

}
