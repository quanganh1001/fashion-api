package org.example.fashion_api.Services.UserService;

import org.example.fashion_api.Models.Account.TokenDTO;
import org.example.fashion_api.Models.Account.AccountLoginDTO;

public interface UserService {
    TokenDTO Login(AccountLoginDTO user);
}
