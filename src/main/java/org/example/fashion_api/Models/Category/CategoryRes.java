package org.example.fashion_api.Models.Category;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CategoryRes {
    private String catName;
    private String catBackground;
    private String catParent;
    private Boolean isCatActive;
}
