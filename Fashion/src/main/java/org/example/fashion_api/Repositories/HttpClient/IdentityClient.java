package org.example.fashion_api.Repositories.HttpClient;

import org.example.fashion_api.Configurations.FeignConfig;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(name = "identityClient",url = "${URI_IDENTITY}",configuration = FeignConfig.class)
public interface IdentityClient {
    @PostMapping(value = "/identity/genToken", produces = MediaType.APPLICATION_JSON_VALUE)
    ResponseEntity<JwtTokenRes> genToken(@RequestBody AccountRes accountRes);

    @GetMapping("/identity/deleteToken")
    void deleteToken(String token);

}
