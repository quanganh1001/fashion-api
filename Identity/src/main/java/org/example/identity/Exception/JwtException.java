package org.example.identity.Exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class JwtException extends RuntimeException{
    private HttpStatus status;

    public JwtException() {
        super("Jwt exception");
        this.status = HttpStatus.UNAUTHORIZED;
    }
}
