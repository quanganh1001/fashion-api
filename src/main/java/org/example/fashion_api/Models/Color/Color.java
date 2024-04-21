package org.example.fashion_api.Models.Color;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "colors")
public class Color {
    @Id
    private String colorId;
    private String name;
}