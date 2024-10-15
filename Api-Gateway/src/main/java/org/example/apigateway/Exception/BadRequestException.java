package org.example.apigateway.Exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class BadRequestException extends RuntimeException{
    private HttpStatus status;

    public BadRequestException(String msg) {
        super(msg);
        this.status = HttpStatus.BAD_REQUEST;
    }
}
