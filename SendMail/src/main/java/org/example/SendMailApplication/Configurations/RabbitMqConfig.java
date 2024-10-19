
package org.example.SendMailApplication.Configurations;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.retry.policy.SimpleRetryPolicy;
import org.springframework.retry.support.RetryTemplate;

import java.text.SimpleDateFormat;

@Configuration
public class RabbitMqConfig {

    @Value("${spring.rabbitmq.mail.exchange}")
    private String mailExchange;

    @Value("${spring.rabbitmq.mail.queue}")
    private String mailQueue;

    @Value("${spring.rabbitmq.mail.key}")
    private String mailKey;

    @Value("${spring.rabbitmq.dead_letter.exchange}")
    private String deadLetterExchange;

    @Value("${spring.rabbitmq.dead_letter.queue}")
    private String deadLetterQueue;

    @Value("${spring.rabbitmq.dead_letter.key}")
    private String deadLetterKey;

    @Value("${spring.rabbitmq.host}")
    private String rabbitHost;

    @Value("${spring.rabbitmq.port}")
    private int rabbitPort;

    @Value("${spring.rabbitmq.username}")
    private String rabbitUsername;

    @Value("${spring.rabbitmq.password}")
    private String rabbitPassword;

    @Bean
    public ConnectionFactory connectionFactory(){
        CachingConnectionFactory factory = new CachingConnectionFactory();
        factory.setHost(rabbitHost);
        factory.setPort(rabbitPort);
        factory.setUsername(rabbitUsername);
        factory.setPassword(rabbitPassword);
        return factory;
    }



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
        rabbitTemplate.setRetryTemplate(retryTemplate());
        return rabbitTemplate;
    }

    @Bean
    public RetryTemplate retryTemplate() {
        RetryTemplate retryTemplate = new RetryTemplate();
        retryTemplate.setRetryPolicy(new SimpleRetryPolicy(1));
        return retryTemplate;
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
                .expires(10000)
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
                .expires(10000)
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

