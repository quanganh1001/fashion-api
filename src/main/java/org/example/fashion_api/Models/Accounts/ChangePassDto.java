package org.example.fashion_api.Models.Accounts;


import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChangePassDto {

    @NotNull
    private String currentPass;

    @NotNull
    private String newPass;

}
