package org.example.fashion_api.Exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class InvalidTokenException extends RuntimeException{
    private HttpStatus status;

    public InvalidTokenException() {
        super("Invalid Token");
        this.status = HttpStatus.UNAUTHORIZED;
    }
}