package org.example.fashion_api.Models.Colors;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "colors")
public class Color extends BaseEntity {
    @NotNull
    private String colorCode;

    private String name;

}