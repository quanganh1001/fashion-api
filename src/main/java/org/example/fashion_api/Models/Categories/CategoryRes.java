package org.example.fashion_api.Models.Categories;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.Products.Product;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CategoryRes {

    private Long id;

    private String categoryCode;

    private String catName;

    private String catBackground;

    private Boolean isActivated;

    private String catParent;
}
