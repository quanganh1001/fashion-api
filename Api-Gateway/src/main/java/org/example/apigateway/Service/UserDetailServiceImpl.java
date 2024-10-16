package org.example.apigateway.Service;

import lombok.RequiredArgsConstructor;
import org.example.apigateway.Models.Accounts.AccountRes;
import org.example.apigateway.Models.UserCustomDetail;
import org.example.apigateway.Repositories.AccountClient;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class UserDetailServiceImpl implements UserDetailsService {

    private final AccountClient accountClient;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

            try {
                // Lấy AccountRes từ AccountClient
                AccountRes account = accountClient.getAccountByPhone(username);

                if (account != null) {
                    return new UserCustomDetail(account);
                }

                account = accountClient.getAccountByEmail(username);
                if (account != null) {
                    return new UserCustomDetail(account);
                } else {
                    throw new UsernameNotFoundException("User not found");
                }
            } catch (Exception e) {
                throw new RuntimeException("Error occurred while loading user: " + e.getMessage());
            }


    }
}
