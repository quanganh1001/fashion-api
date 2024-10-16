package org.example.fashion_api.Models.Categories;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UpdateCategoryDto   {

    @NotNull
    private String categoryCode;

    @NotNull
    private String catName;

    private Long catParent;
}
