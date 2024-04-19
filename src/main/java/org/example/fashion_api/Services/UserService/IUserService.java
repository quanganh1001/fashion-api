package org.example.fashion_api.Services.UserService;

import org.example.fashion_api.Models.User.TokenDTO;
import org.example.fashion_api.Models.User.UserLoginDTO;

public interface IUserService {
    TokenDTO Login(UserLoginDTO user);
}
