package org.example.fashion_api.Models.Colors;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
public class ColorRes {
    private Long id;

    private String colorCode;

    private String name;
}
