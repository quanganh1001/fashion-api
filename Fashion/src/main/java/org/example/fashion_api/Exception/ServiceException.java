package org.example.fashion_api.Exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class ServiceException extends RuntimeException{
    private HttpStatus status;

    public ServiceException(String obj) {
        super("INTERNAL SERVER ERROR: " + obj);
        this.status = HttpStatus.INTERNAL_SERVER_ERROR;
    }
}