package org.example.fashion_api.Models.JwtToken;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.fashion_api.Models.Account.Account;

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

    @OneToOne
    @JoinColumn(name = "accountId")
    private Account account;

    @PrePersist
    public void prePersist() {
        if (revoked == null)
            revoked = false;
    }
}
