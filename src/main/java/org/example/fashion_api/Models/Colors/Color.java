package org.example.fashion_api.Models.Colors;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "colors")
public class Color {
    @Id
    private String colorId;
    private String name;

}