package org.example.fashion_api.Services.RedisService;


import com.fasterxml.jackson.core.JsonProcessingException;
import org.example.fashion_api.Models.Category.Category;


import java.util.List;

public interface RedisService {
    void clear();


    <T> void saveRedis(String keyRedis, T object) throws JsonProcessingException;

    <T> List<T> getListRedis(String keyRedis, Class<T> clazz) throws JsonProcessingException;

    <T> T getRedis(String keyRedis, Class<T> clazz) throws JsonProcessingException;
}
