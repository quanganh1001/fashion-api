package org.example.fashion_api.Models.Account;


import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TokenDTO {

    private String token;

    private String role;

}
