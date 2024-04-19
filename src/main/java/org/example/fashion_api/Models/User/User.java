package org.example.fashion_api.Models.User;


import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Enum.RoleEnumDTO;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "accounts")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer accountId;

    private String username;

    private String password;

    private String name;

    private String phone;

    private String email;

    private String address;

    private Boolean enabled;

    @Enumerated(EnumType.STRING)
    private RoleEnumDTO role;

}
