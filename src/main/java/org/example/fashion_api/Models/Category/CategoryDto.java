package org.example.fashion_api.Models.Category;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDto   {

    @NotNull
    private String catId;

    @NotNull
    private String catName;

    private String catBackground;

    private String catParent;

    @NotNull
    private Boolean isCatActive;


}
