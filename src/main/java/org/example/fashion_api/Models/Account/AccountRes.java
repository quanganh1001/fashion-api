package org.example.fashion_api.Models.Account;


import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.Setter;
import org.example.fashion_api.Enum.RoleEnumDTO;

@Setter
@Getter
public class AccountRes {

    private String username;

    private String name;

    private String phone;

    private String email;

    private String address;

    private Boolean enabled;

    @Enumerated(EnumType.STRING)
    private RoleEnumDTO role;

}
