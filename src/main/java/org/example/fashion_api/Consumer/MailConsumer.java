package org.example.fashion_api.Consumer;

import org.example.fashion_api.Models.MailTemplate;
import org.example.fashion_api.Services.EmailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MailConsumer {

    private static final Logger logger = LoggerFactory.getLogger(MailConsumer.class);

    @Autowired
    private EmailService mailService;

    @RabbitListener(queues = "${rabbitmq.mail.queue}")
    public void consume(MailTemplate mailTemplate){
        logger.info("Processing mail request -> {}", mailTemplate.getTo());
        mailService.sendEmail(mailTemplate);

    }

}