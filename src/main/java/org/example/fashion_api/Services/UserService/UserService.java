package org.example.fashion_api.Services.UserService;

import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Models.Token.TokenRes;

public interface UserService {
    TokenRes Login(AccountLoginDTO user);
}
