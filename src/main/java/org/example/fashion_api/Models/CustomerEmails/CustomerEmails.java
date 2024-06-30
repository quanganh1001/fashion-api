package org.example.fashion_api.Models.CustomerEmails;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;

@EqualsAndHashCode(callSuper = true)
@Table(name = "customer_emails")
@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class CustomerEmails extends BaseEntity {
    private String email;
}
