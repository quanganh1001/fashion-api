package org.example.fashion_api.Models.Color;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class ColorDto {
    @NotNull
    private String colorId;

    @NotNull
    private String name;
}
