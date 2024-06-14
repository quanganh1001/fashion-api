package org.example.fashion_api.Models.Accounts;


import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.example.fashion_api.Enum.RoleEnum;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.JwtToken.JwtToken;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.RedisListener;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor(force = true)
@EntityListeners(RedisListener.class)
@Builder
@Entity
@Data
@Table(name = "accounts")
public class Account extends BaseEntity {

    @NotNull
    private String password;

    private String name;

    @NotNull
    private String phone;

    @NotNull
    private String email;

    private String address;

    private Boolean isActivated = Boolean.TRUE;

    @NotNull
    @Enumerated(EnumType.STRING)
    private RoleEnum role = RoleEnum.ROLE_CUSTOMER;

    @OneToMany(mappedBy = "account",cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<JwtToken> tokens;

}
