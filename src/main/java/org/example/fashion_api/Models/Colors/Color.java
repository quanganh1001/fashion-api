package org.example.fashion_api.Models.Colors;

import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "colors")
public class Color extends BaseEntity {

    private String colorCode;

    private String name;

}