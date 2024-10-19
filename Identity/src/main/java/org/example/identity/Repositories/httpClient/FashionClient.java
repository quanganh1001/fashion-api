package org.example.identity.Repositories.httpClient;

import org.example.identity.Configuation.FeignConfig;
import org.example.identity.Models.Accounts.AccountLoginDto;
import org.example.identity.Models.Accounts.AccountRes;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@FeignClient(name = "fashionClient", url = "${URI_FASHION}",configuration = FeignConfig.class)
public interface FashionClient {

    @GetMapping(value = "/accounts/getByPhone/{phoneNumber}",produces = MediaType.APPLICATION_JSON_VALUE)
    AccountRes getAccountByPhone(@PathVariable("phoneNumber") String phoneNumber);

    @GetMapping(value = "/accounts/getByEmail/{email}",produces = MediaType.APPLICATION_JSON_VALUE)
    AccountRes getAccountByEmail(@PathVariable("email") String email);

    @PostMapping(value = "/auth/verifyLogin",produces = MediaType.APPLICATION_JSON_VALUE)
    AccountRes verifyLogin(@RequestBody AccountLoginDto loginRequest, @RequestParam(value = "validRoles") List<String> validRoles);

}


