package org.example.fashion_api.Models.FeedbackCustomers;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;

@EqualsAndHashCode(callSuper = true)
@Table(name = "feedback_customers")
@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
public class FeedbackCustomer extends BaseEntity {
    private String email;
    private String name;
    private String feedback;
    private boolean isReaded = false;
}
