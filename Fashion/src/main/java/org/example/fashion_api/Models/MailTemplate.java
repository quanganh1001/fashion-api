package org.example.fashion_api.Models;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MailTemplate implements Serializable {

    @NotNull
    @Email
    String to;

    @NotNull
    String subject;

    @NotNull
    String body;

    byte[] file;

    String fileName;

}
