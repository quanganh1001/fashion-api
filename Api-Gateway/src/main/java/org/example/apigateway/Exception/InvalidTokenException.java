package org.example.apigateway.Exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class InvalidTokenException extends RuntimeException{
    private HttpStatus status;

    public InvalidTokenException(String message) {
        super(message + " Invalid");
        this.status = HttpStatus.UNAUTHORIZED;
    }
}