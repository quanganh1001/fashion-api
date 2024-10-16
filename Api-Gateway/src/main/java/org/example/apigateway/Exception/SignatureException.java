package org.example.apigateway.Exception;


import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class SignatureException extends RuntimeException{
    private HttpStatus status;

    public SignatureException() {
        super("Invalid signature");
        this.status = HttpStatus.UNAUTHORIZED;
    }
}
