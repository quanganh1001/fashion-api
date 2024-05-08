package org.example.fashion_api.Models.Product;

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
