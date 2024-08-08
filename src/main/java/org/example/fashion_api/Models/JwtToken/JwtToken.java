package org.example.fashion_api.Models.JwtToken;

import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.AccountsAdmin.AccountAdmin;
import org.example.fashion_api.Models.BaseEntity;

import java.util.Date;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "jwt_tokens")
public class JwtToken extends BaseEntity {


    private String token;

    private Date expirationDate;

    private String refreshToken;

    private Date refreshExpirationDate;

    private Boolean revoked;

    @ManyToOne
    @JoinColumn(name = "accountId")
    private AccountAdmin accountAdmin;

    @PrePersist
    public void prePersist() {
        if (revoked == null)
            revoked = false;
    }
}
