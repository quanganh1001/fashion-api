package org.example.fashion_api.Models.Categories;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDto   {

    @NotNull
    private String categoryCode;

    @NotNull
    private String catName;

    private String catBackground;

    private String catParent;

    private Boolean isActivated = true;
}
