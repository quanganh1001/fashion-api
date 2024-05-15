package org.example.fashion_api.Models.Categories;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.RedisListener;

import java.util.List;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor(force = true)
@Table(name = "categories")
@EntityListeners(RedisListener.class)
public class Category extends BaseEntity {

    private String categoryCode;

    private String catName;

    private String catBackground;

    private Boolean isActivated = Boolean.TRUE;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<Product> product;

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Category catParent;




}
