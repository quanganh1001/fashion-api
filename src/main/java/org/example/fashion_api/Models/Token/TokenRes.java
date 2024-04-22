package org.example.fashion_api.Models.Token;


import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TokenRes {

    private String token;

    private String refreshToken;

    private String role;

}
