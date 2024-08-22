package org.example.fashion_api.Models.StoresAddress;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@Table(name = "stores")
@NoArgsConstructor(force = true)
@AllArgsConstructor
@Builder
public class StoresAddress extends BaseEntity {
    private String name;
    private String address;
    private String time;
    private String phone;
    private String api;
    private String city;
}
