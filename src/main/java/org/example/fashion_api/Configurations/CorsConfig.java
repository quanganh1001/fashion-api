package org.example.fashion_api.Configurations;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;


@Configuration
public class CorsConfig {
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOrigins("http://localhost:3000") // Chỉ cho phép localhost:3000
                        .allowedMethods("*") // Cho phép tất cả phương thức HTTP
                        .allowedHeaders("*") // Cho phép tất cả các tiêu đề
                        .exposedHeaders("*"); // Cho phép tất cả các tiêu đề trong phản hồi
            }
        };
    }
}