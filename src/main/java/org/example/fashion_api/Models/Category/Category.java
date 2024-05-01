package org.example.fashion_api.Models.Category;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.Product.Product;
import org.example.fashion_api.Models.RedisListener;
import org.example.fashion_api.Services.RedisService.RedisService;

import java.io.Serializable;
import java.util.List;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor(force = true)
@Table(name = "categories")
@EntityListeners(RedisListener.class)
public class Category   {
    @Id
    private String catId;
    private String catName;
    private String catBackground;
    private Boolean isCatActive;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL,orphanRemoval = true,fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<Product> product;

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Category catParent;


    @PrePersist
    public void prePersist() {
        if (isCatActive == null)
            isCatActive = true;
    }

}
