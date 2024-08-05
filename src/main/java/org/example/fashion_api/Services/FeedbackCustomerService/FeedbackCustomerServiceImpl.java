package org.example.fashion_api.Services.FeedbackCustomerService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.FeedbackCustomers.FeedbackCustomer;
import org.example.fashion_api.Models.FeedbackCustomers.PageFeedbackCustomer;
import org.example.fashion_api.Models.MailTemplate;
import org.example.fashion_api.Producer.MailProducer;
import org.example.fashion_api.Repositories.FeedbackCustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class FeedbackCustomerServiceImpl implements FeedbackCustomerService {
    private final FeedbackCustomerRepo feedbackCustomerRepo;
    private final MailProducer mailProducer;

    @Override
    public PageFeedbackCustomer findAll(int page, int limit) {
        if(page < 0){
            page = 0;
        }
        PageRequest pageRequest = PageRequest.of(page,limit, Sort.by("createdAt").descending());


        Page<FeedbackCustomer> pageFeedbackCustomer = feedbackCustomerRepo.findAll(pageRequest);
        return PageFeedbackCustomer.builder()
                .feedbackCustomers(pageFeedbackCustomer.getContent())
                .totalItems(pageFeedbackCustomer.getTotalElements())
                .totalPages(pageFeedbackCustomer.getTotalPages())
                .currentPage(page+1)
                .build();
    }

    @Override
    public void save(FeedbackCustomer feedbackCustomer){

        feedbackCustomerRepo.save(feedbackCustomer);

        mailProducer.send(MailTemplate.builder()
                .to(feedbackCustomer.getEmail())
                .subject("Torano - Tiếp nhận phản hồi")
                .body("Chúng tôi sẽ liên hệ lại với bạn")
                .build());
    }


    @Override
    public Integer countUnread(){
        return feedbackCustomerRepo.countByIsReadedFalse();

    }

    @Override
    @Transactional
    public void setUnread(Long id){
        feedbackCustomerRepo.setUnreadFeedback(id);
    }

    @Override
    @Transactional
    public void readFeedback(Long id) {
        feedbackCustomerRepo.setReadFeedback(id);

    }

}
