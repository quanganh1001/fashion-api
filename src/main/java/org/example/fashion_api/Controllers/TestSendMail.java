package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import org.example.fashion_api.Models.MailTemplate;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.example.fashion_api.Producer.MailProducer;
import org.example.fashion_api.Services.ProductDetailService.ProductDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/testMail")
public class TestSendMail {
    @Autowired
    private MailProducer mailProducer;


    @Operation(summary = "test send mail")
    @PostMapping("/sendMail")
    public void sendMail(@Valid @RequestBody MailTemplate mailTemplate) {
        mailProducer.send(mailTemplate);
    }
}
