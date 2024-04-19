package org.example.fashion_api.Models.User;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.fashion_api.Enum.RoleEnumDTO;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "accounts")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer accountId;

    private String userName;

    private String password;

    private String name;

    private String phone;

    private String email;

    private String address;

    private Boolean enabled;

    @Enumerated(EnumType.STRING)
    private RoleEnumDTO role;

}
