package org.example.fashion_api.Models.FeedbackCustomers;

import lombok.*;
import org.example.fashion_api.Models.Accounts.AccountRes;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PageFeedbackCustomer {

    private List<FeedbackCustomer> feedbackCustomers;

    private int totalPages;

    private int currentPage;

    private Long totalItems;
}
