package org.example.fashion_api.Services.RedisService;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
@RequiredArgsConstructor
public class RedisServiceImpl implements RedisService {
    private final RedisTemplate<String, Object> redisTemplate;
    private final ObjectMapper redisObjectMapper;

    @Override
    public void clear() {
        redisTemplate.getConnectionFactory().getConnection().flushAll();
    }


    @Override
    public <T> void saveRedis(String keyRedis, T object) throws JsonProcessingException {
        try {
            String json = redisObjectMapper.writeValueAsString(object);
            redisTemplate.opsForValue().set(keyRedis, json);
        } catch (JsonProcessingException e) {
            // Xử lý ngoại lệ tại đây (ví dụ: log và báo lỗi)
            e.printStackTrace();
        }
    }

    @Override
    public <T> List<T> getListRedis(String keyRedis, Class<T> clazz) throws JsonProcessingException {
        String json = (String) redisTemplate.opsForValue().get(keyRedis);
        return json != null ?
                redisObjectMapper.readValue(json, redisObjectMapper.getTypeFactory().constructCollectionType(List.class, clazz))
                : null;
    }

    @Override
    public <T> T getRedis(String keyRedis, Class<T> clazz) throws JsonProcessingException {
        String json = (String) redisTemplate.opsForValue().get(keyRedis);
        return json != null ?
                redisObjectMapper.readValue(json, redisObjectMapper.getTypeFactory().constructCollectionType(List.class, clazz))
                : null;
    }
}
