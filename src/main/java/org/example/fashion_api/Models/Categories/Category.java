package org.example.fashion_api.Models.Categories;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.RedisListener;

import java.util.List;

@Entity
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor(force = true)
@Table(name = "categories")
public class Category extends BaseEntity {
    @NotNull
    private String categoryCode;

    private String catName;

    private String catBackground;

    @OneToMany(mappedBy = "category")
    @JsonIgnore
    @ToString.Exclude
    private List<Product> product;

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Category catParent;




}
