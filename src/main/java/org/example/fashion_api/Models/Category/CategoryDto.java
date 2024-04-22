package org.example.fashion_api.Models.Category;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDto implements Serializable {
    private String catName;
    private String catBackground;
    private Boolean isCatActive;
    private String catParent;

}
