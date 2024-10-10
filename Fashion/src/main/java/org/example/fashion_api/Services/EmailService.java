package org.example.fashion_api.Services;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Exception.ServiceException;
import org.example.fashion_api.Models.MailTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ServerErrorException;


@Service
@RequiredArgsConstructor
public class EmailService {
    private final JavaMailSender javaMailSender;

    public void sendEmail(MailTemplate mailTemplate){
        try{
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom("quanganhnguyen100196@gmail.com");
            helper.setTo(mailTemplate.getTo());
            helper.setSubject(mailTemplate.getSubject());
            helper.setText(mailTemplate.getBody());

            if(mailTemplate.getFile() != null && mailTemplate.getFileName() != null){
                helper.addAttachment(mailTemplate.getFileName(), new ByteArrayResource(mailTemplate.getFile()));
            }

            javaMailSender.send(message);
        }catch(MessagingException e){
            throw new ServiceException("Unable to send email");
        }
    }

}