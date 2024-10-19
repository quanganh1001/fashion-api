package org.example.SendMailApplication.Models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MailTemplate {

    String to;

    String subject;

    String body;

    byte[] file;

    String fileName;

}
