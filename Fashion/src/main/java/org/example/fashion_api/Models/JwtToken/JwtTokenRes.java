package org.example.fashion_api.Models.JwtToken;


import lombok.*;
import org.example.fashion_api.Models.Accounts.AccountRes;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class JwtTokenRes {

    private String token;

    private String refreshToken;

    private AccountRes account;

}
