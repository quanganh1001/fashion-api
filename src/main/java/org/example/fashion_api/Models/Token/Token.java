package org.example.fashion_api.Models.Token;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.fashion_api.Models.Account.Account;
import org.example.fashion_api.Models.Category.Category;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "tokens")
public class Token {
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
