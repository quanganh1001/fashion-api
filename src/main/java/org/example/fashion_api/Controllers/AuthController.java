package org.example.fashion_api.Controllers;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping()
public class AuthController {
    @PostMapping("login")
    public String Login(){
        return null;
    }
}
