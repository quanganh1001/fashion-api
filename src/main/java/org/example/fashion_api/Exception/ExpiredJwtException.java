package org.example.fashion_api.Exception;


import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class ExpiredJwtException extends RuntimeException{
    private HttpStatus status;

    public ExpiredJwtException() {
        super("Token has expired");
        this.status = HttpStatus.UNAUTHORIZED;
    }
}
