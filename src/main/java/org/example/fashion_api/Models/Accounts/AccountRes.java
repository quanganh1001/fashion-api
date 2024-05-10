package org.example.fashion_api.Models.Accounts;


import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.Setter;
import org.example.fashion_api.Enum.RoleEnum;

@Setter
@Getter
public class AccountRes {

    private Long accountId;

    private String username;

    private String name;

    private String phone;

    private String email;

    private String address;

    private Boolean enabled;

    @Enumerated(EnumType.STRING)
    private RoleEnum role;

}
