package org.example.apigateway.Repositories;

import org.example.apigateway.Configurations.FeignConfig;
import org.example.apigateway.Models.Accounts.AccountRes;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import reactor.core.publisher.Mono;

import java.util.Optional;


@FeignClient(name = "account-service",url = "http://localhost:8081", configuration = FeignConfig.class)
public interface AccountClient {

    @GetMapping(value = "/accounts/getByPhone/{phoneNumber}",produces = MediaType.APPLICATION_JSON_VALUE)
    AccountRes getAccountByPhone(@PathVariable("phoneNumber") String phoneNumber);

    @GetMapping(value = "/accounts/getByEmail/{email}",produces = MediaType.APPLICATION_JSON_VALUE)
    AccountRes getAccountByEmail(@PathVariable("email") String email);
}
