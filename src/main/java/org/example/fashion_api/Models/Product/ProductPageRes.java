package org.example.fashion_api.Models.Product;

import lombok.*;
import org.example.fashion_api.Models.Account.AccountRes;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductPageRes {

    private List<ProductRes> productsRes;

    private int totalPages;


}
