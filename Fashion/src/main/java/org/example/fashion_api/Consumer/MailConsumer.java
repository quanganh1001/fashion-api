//package org.example.fashion_api.Consumer;
//
//import lombok.RequiredArgsConstructor;
//import org.example.fashion_api.Models.MailTemplate;
//import org.example.fashion_api.Services.EmailService;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.amqp.rabbit.annotation.RabbitListener;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//@Service
//@RequiredArgsConstructor
//public class MailConsumer {
//
//    private static final Logger logger = LoggerFactory.getLogger(MailConsumer.class);
//
//    private final EmailService mailService;
//
//    @RabbitListener(queues = "${rabbitmq.mail.queue}")
//    public void consume(MailTemplate mailTemplate){
//        logger.info("Processing mail request -> {}", mailTemplate.getTo());
//        mailService.sendEmail(mailTemplate);
//
//    }
//
//}