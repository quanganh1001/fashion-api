package org.example.identity.Repositories.httpClient;

import org.example.identity.Models.Accounts.AccountRes;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;


@FeignClient(name = "fashionClient", url = "http://localhost:8081")
public interface FashionClient {
    @GetMapping(value = "/accounts/current")
    AccountRes getCurrentAccount();
}

