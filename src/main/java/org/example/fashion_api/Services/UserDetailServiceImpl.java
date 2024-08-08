package org.example.fashion_api.Services;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.UserCustomDetail;
import org.example.fashion_api.Repositories.AccountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserDetailServiceImpl implements UserDetailsService {

    private final AccountRepo accountRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<Account> findByUser = accountRepo.findByPhone(username);
        return UserCustomDetail.builder().account(findByUser.get()).build();
    }
}
