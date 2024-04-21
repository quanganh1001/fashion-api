package org.example.fashion_api.Models.Account;


import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Setter;
import org.example.fashion_api.Enum.RoleEnumDTO;

@AllArgsConstructor
@Setter
public class AccountRes {

    private String userName;

    private String name;

    private String phone;

    private String email;

    private String address;

    private Boolean enabled;

    @Enumerated(EnumType.STRING)
    private RoleEnumDTO role;

}
