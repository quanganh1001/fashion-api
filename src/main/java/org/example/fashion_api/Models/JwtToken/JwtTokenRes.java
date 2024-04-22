package org.example.fashion_api.Models.JwtToken;


import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class JwtTokenRes {

    private String token;

    private String refreshToken;

    private String role;

}
