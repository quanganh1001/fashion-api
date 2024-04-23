package org.example.fashion_api.Models.Account;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccountLoginDto {
    @NotBlank
    private String username;

    @NotBlank
    private String password;
}
