package org.example.fashion_api.Models.Category;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import project.model.Product.Product;

import java.util.List;

@Entity
@Data
@Table(name = "categories")
public class Category {
    @Id
    private String catId;
    private String catName;
    private String catBackground;
    private Boolean isCatActive;

    @OneToMany(mappedBy = "category", cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
    @JsonIgnore
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
