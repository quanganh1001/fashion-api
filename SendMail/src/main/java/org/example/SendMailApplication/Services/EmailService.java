package org.example.SendMailApplication.Services;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

import org.example.SendMailApplication.Models.MailTemplate;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.rmi.ServerException;


@Service
@RequiredArgsConstructor
public class EmailService {
    private final JavaMailSender javaMailSender;

    public void sendEmail(MailTemplate mailTemplate) throws ServerException {
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
            throw new ServerException("Unable to send email");
        }
    }

}