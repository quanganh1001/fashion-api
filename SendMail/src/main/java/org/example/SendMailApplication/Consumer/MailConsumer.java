package org.example.SendMailApplication.Consumer;

import lombok.RequiredArgsConstructor;

import org.example.SendMailApplication.Models.MailTemplate;
import org.example.SendMailApplication.Services.EmailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

import java.rmi.ServerException;

@Service
@RequiredArgsConstructor
public class MailConsumer {

    private static final Logger logger = LoggerFactory.getLogger(MailConsumer.class);

    private final EmailService mailService;

    @RabbitListener(queues = "${rabbitmq.mail.queue}")
    public void consume(MailTemplate mailTemplate) throws ServerException {
        logger.info("Processing mail request -> {}", mailTemplate.getTo());
        mailService.sendEmail(mailTemplate);

    }

}