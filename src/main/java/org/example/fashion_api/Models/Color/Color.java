package org.example.fashion_api.Models.Color;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.ProductDetail.ProductDetail;

import java.util.List;

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