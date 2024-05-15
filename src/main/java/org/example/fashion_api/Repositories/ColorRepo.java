package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Colors.Color;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ColorRepo extends JpaRepository<Color,Long> {
    Boolean existsByColorCode(String colorCode);
}
