package org.example.apigateway.Models.Accounts;


import lombok.Getter;
import lombok.Setter;
import org.example.apigateway.Enum.RoleEnum;

@Setter
@Getter
public class AccountRes {

    private Long id;

    private String name;

    private String phone;

    private String email;

    private String address;

    private Boolean isActivated;

    private String role;

}
