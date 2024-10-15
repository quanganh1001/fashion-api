package org.example.apigateway.Configurations;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.config.CorsRegistry;
import org.springframework.web.reactive.config.WebFluxConfigurer;

@Configuration
public class CorsConfig {
    @Bean
    public WebFluxConfigurer corsConfigurer() {
        return new WebFluxConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOrigins("*") // Hoặc chỉ định các nguồn cụ thể
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // Chỉ định các phương thức HTTP cụ thể
                        .allowedHeaders("*")
                        .exposedHeaders("*")
                        .allowCredentials(true); // Cho phép cookie và authorization headers
            }
        };
    }
}