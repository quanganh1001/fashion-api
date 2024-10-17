package org.example.identity.Models.JwtToken;


import lombok.*;
import org.example.identity.Models.Accounts.AccountRes;

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
