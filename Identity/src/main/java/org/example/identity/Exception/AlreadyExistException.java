package org.example.identity.Exception;


import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class AlreadyExistException extends RuntimeException {
    private HttpStatus status;

    public AlreadyExistException(String obj) {
        super(obj + " already exist");
        this.status = HttpStatus.CONFLICT;
    }

}
