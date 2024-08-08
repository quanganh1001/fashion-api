package org.example.fashion_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "org.example.fashion_api.Repositories")
public class FashionApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(FashionApiApplication.class, args);
	}

}
