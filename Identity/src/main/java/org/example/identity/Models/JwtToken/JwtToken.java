package org.example.identity.Models.JwtToken;

import jakarta.persistence.*;
import lombok.*;


import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "jwt_tokens")
public class JwtToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String token;

    private Date expirationDate;

    private String refreshToken;

    private Date refreshExpirationDate;

    private Boolean revoked;

    private Long accountId;

    @PrePersist
    public void prePersist() {
        if (revoked == null)
            revoked = false;
    }
}
