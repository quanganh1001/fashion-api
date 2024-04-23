package org.example.fashion_api.Models.Account;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.RoleEnumDTO;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Data
@Table(name = "accounts")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long accountId;

    @NotNull
    private String username;

    @NotNull
    private String password;

    private String name;

    @NotNull
    private String phone;

    @NotNull
    private String email;

    private String address;

    @NotNull
    private Boolean enabled;

    @NotNull
    @Enumerated(EnumType.STRING)
    private RoleEnumDTO role;

    @PrePersist
    public void prePersist() {
        if (enabled == null)
            enabled = true;
        if (role == null){
            role = RoleEnumDTO.ROLE_CUSTOMER;
        }
    }
}
