package org.example.fashion_api.Configurations;

import com.cloudinary.Cloudinary;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class CloudinaryConfig {
    @Bean
    public Cloudinary getCloudinary(){
        Map config = new HashMap();
        config.put("cloud_name", "dmmvhjl0m");
        config.put("api_key", "478174116475553");
        config.put("api_secret", "kmkIN1OYarMbUDxotQK51o8W5FM");
        config.put("secure", true);
        return new Cloudinary(config);
    }
}
