package org.example.fashion_api.Models;

import lombok.*;
import org.example.fashion_api.Models.AccountsAdmin.AccountAdmin;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserCustomDetail implements UserDetails {

    private AccountAdmin accountAdmin;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(accountAdmin.getRole().name()));
    }

    @Override
    public String getPassword() {
        return accountAdmin.getPassword();
    }

    @Override
    public String getUsername() {
        return accountAdmin.getPhone();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return accountAdmin.getIsActivated();
    }
}
