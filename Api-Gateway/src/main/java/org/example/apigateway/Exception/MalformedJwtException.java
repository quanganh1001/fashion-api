package org.example.apigateway.Exception;


import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class MalformedJwtException extends RuntimeException{
    private HttpStatus status;

    public MalformedJwtException() {
        super("Malformed JWT");
        this.status = HttpStatus.UNAUTHORIZED;
    }
}
