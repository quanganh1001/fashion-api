package org.example.fashion_api.Services.FeedbackCustomerService;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.FeedbackCustomers.FeedbackCustomer;
import org.example.fashion_api.Models.FeedbackCustomers.PageFeedbackCustomer;
import org.springframework.data.domain.Page;

import java.util.List;

public interface FeedbackCustomerService {


    PageFeedbackCustomer findAll(int page, int size);

    void save(FeedbackCustomer feedbackCustomer);

    Integer countUnread();

    void setUnread(Long id);

    void readFeedback(Long id);
}
