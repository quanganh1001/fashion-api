package org.example.apigateway.HttpClient;


import org.example.apigateway.Configurations.FeignConfig;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@FeignClient(name = "identity-service",url = "http://localhost:8082", configuration = FeignConfig.class)
public interface IdentityClient {
    @GetMapping(value = "/identity/verifyToken",produces = MediaType.APPLICATION_JSON_VALUE)
    String verifyToken(@RequestParam("jwt") String jwt,@RequestParam("id") Long id);

}
