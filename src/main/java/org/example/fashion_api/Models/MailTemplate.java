package org.example.fashion_api.Models;

import lombok.*;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MailTemplate implements Serializable {

    String to;

    String subject;

    String body;

    byte[] file;

    String fileName;

}
