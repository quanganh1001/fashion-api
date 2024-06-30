package org.example.fashion_api.Services.CustomerEmailService;

import org.example.fashion_api.Models.CustomerEmails.EmailTemplate;
import org.springframework.http.ResponseEntity;

public interface CustomerEmailService {

    void save(String email);

    void sendEmail(EmailTemplate emailTemplate);
}
