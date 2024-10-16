package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.CustomerEmails.CustomerEmails;
import org.example.fashion_api.Models.CustomerEmails.EmailTemplate;
import org.example.fashion_api.Services.CustomerEmailService.CustomerEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("email")
public class EmailController {
    private final CustomerEmailService customerEmailService;

    @PostMapping("/send")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "Send email to all registered customers")
    public ResponseEntity<String> sendEmail(@RequestBody EmailTemplate emailTemplate) {
        customerEmailService.sendEmail(emailTemplate);
        return ResponseEntity.ok("Email sent");
    }

    @PostMapping("/register")
    @Operation(summary = "Sign up to receive news via email")
    public ResponseEntity<String> registerMail(@RequestBody String email) {
        customerEmailService.save(email);
        return ResponseEntity.ok("Email registered successfully");
    }

}
