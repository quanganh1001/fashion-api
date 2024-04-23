package org.example.fashion_api.Services;

import org.example.fashion_api.Models.Account.Account;
import org.example.fashion_api.Models.UserCustomDetail;
import org.example.fashion_api.Repositories.AccountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserDetailServiceImpl implements UserDetailsService {

    @Autowired
    private AccountRepo accountRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<Account> findByUser = accountRepo.findByUsername(username);
        return UserCustomDetail.builder().account(findByUser.get()).build();
    }
}
