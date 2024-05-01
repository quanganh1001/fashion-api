package org.example.fashion_api.Models;

import jakarta.persistence.PostPersist;
import jakarta.persistence.PostRemove;
import jakarta.persistence.PostUpdate;
import jakarta.persistence.Transient;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import org.example.fashion_api.Services.RedisService.RedisService;


@RequiredArgsConstructor
public class RedisListener {

    final private RedisService redisService;

    @PostPersist
    public <T> void postPersist(T object) {
        redisService.clear();
    }

    @PostUpdate
    public <T> void postUpdate(T object) {
        redisService.clear();
    }

    @PostRemove
    public <T> void postRemove(T object) {
        redisService.clear();
    }
}
