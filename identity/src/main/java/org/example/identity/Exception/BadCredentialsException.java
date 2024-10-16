package org.example.identity.Exception;


import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class BadCredentialsException extends RuntimeException{
    private HttpStatus status;

    public BadCredentialsException() {
        super("Invalid username or password");
        this.status = HttpStatus.UNAUTHORIZED;
    }
}
