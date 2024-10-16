package org.example.apigateway.Exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class NotFoundException extends RuntimeException{
    private HttpStatus status;

    public NotFoundException(String obj) {
        super(obj + " not found");
        this.status = HttpStatus.NOT_FOUND;
    }

}