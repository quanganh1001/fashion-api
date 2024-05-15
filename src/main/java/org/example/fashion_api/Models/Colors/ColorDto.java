package org.example.fashion_api.Models.Colors;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class ColorDto {
    @NotNull
    private String colorCode;

    @NotNull
    private String name;
}
