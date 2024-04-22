package org.example.fashion_api.Services.UserService;

import org.example.fashion_api.Models.Account.AccountLoginDTO;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;

public interface UserService {
    JwtTokenRes Login(AccountLoginDTO user);


}
