package org.example.fashion_api.Models.Accounts;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.example.fashion_api.Enum.RoleEnum;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccountUpdateDto {

    @Email
    @NotBlank
    private String email;

    @NotBlank
    @NotNull
    private String phone;

    @NotBlank
    private String name;

    @NotBlank
    private String address;

}
