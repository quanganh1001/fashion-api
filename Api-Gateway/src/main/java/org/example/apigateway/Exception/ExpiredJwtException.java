package org.example.apigateway.Exception;


import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class ExpiredJwtException extends RuntimeException{
    private HttpStatus status;

    public ExpiredJwtException(String message) {
        super(message+ " has expired");
        this.status = HttpStatus.UNAUTHORIZED;

    }
}
