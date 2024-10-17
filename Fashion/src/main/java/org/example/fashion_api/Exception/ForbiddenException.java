package org.example.fashion_api.Exception;


import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class ForbiddenException extends RuntimeException{
    private HttpStatus status;

    public ForbiddenException() {
        super("Forbidden");
        this.status = HttpStatus.FORBIDDEN;
    }
}
