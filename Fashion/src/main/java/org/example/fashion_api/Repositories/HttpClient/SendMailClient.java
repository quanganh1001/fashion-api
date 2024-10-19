package org.example.fashion_api.Repositories.HttpClient;

import org.example.fashion_api.Configurations.FeignConfig;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Models.JwtToken.JwtTokenRes;
import org.example.fashion_api.Models.MailTemplate;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(name = "sendMailClient",url = "http://localhost:8083",configuration = FeignConfig.class)
public interface SendMailClient {
    @PostMapping(value = "/sendMail", produces = MediaType.APPLICATION_JSON_VALUE)
    ResponseEntity<Void> sendMail(@RequestBody MailTemplate mailTemplate);
}
