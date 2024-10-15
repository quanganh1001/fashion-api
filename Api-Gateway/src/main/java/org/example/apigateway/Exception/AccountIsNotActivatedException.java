package org.example.apigateway.Exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class AccountIsNotActivatedException extends RuntimeException{
    private HttpStatus status;

    public AccountIsNotActivatedException() {
        super("Account has been deactivated");
        this.status = HttpStatus.UNAUTHORIZED;
    }
}
