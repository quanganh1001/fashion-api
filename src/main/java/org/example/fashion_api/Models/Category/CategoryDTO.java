package org.example.fashion_api.Models.Category;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
public class CategoryDTO {
    private String catName;
    private String catBackground;
    private Boolean isCatActive;
    private String catParent;
}
