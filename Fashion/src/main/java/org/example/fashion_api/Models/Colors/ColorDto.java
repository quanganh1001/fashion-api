package org.example.fashion_api.Models.Colors;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ColorDto {
    @NotNull
    private String colorCode;

    @NotNull
    private String name;
}
