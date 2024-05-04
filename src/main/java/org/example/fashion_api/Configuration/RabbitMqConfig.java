
package org.example.fashion_api.Configuration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.text.SimpleDateFormat;

@Configuration
public class RabbitMqConfig {

    @Value("${rabbitmq.mail.exchange}")
    private String mailExchange;

    @Value("${rabbitmq.mail.queue}")
    private String mailQueue;

    @Value("${rabbitmq.mail.key}")
    private String mailKey;

    @Value("${rabbitmq.dead_letter.exchange}")
    private String deadLetterExchange;

    @Value("${rabbitmq.dead_letter.queue}")
    private String deadLetterQueue;

    @Value("${rabbitmq.dead_letter.key}")
    private String deadLetterKey;

    @Bean
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        return objectMapper;
    }

    @Bean
    public MessageConverter messageConverter(){
        return new Jackson2JsonMessageConverter(objectMapper());
    }

    @Bean
    public AmqpTemplate amqpTemplate(ConnectionFactory factory){
        RabbitTemplate rabbitTemplate = new RabbitTemplate(factory);
        rabbitTemplate.setMessageConverter(messageConverter());
        return rabbitTemplate;
    }



    @Bean
    public TopicExchange mailExchange(){
        return new TopicExchange(mailExchange);
    }

    @Bean
    public Queue mailQueue(){
        return QueueBuilder
                .durable(mailQueue)
                .deadLetterExchange(deadLetterExchange)
                .deadLetterRoutingKey(deadLetterKey)
                .build();
    }

    @Bean
    public Binding mailQueueBinding(){
        return BindingBuilder
                .bind(mailQueue())
                .to(mailExchange())
                .with(mailKey);
    }

    @Bean
    public DirectExchange deadLetterExchange() {
        return new DirectExchange(deadLetterExchange);
    }

    @Bean
    public Queue deadLetterQueue(){
        return QueueBuilder
                .durable(deadLetterQueue)
                .build();
    }

    @Bean
    public Binding deadLetterQueueBinding(){
        return BindingBuilder
                .bind(deadLetterQueue())
                .to(deadLetterExchange())
                .with(deadLetterKey);
    }
}

