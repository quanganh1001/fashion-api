package org.example.fashion_api.Services.CustomerEmailService;

import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.CustomerEmails.CustomerEmails;
import org.example.fashion_api.Models.CustomerEmails.EmailTemplate;
import org.example.fashion_api.Models.MailTemplate;
import org.example.fashion_api.Producer.MailProducer;
import org.example.fashion_api.Repositories.AccountRepo;
import org.example.fashion_api.Repositories.CustomerEmailRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomerEmailServiceImpl implements CustomerEmailService{
    @Autowired
    private CustomerEmailRepo customerEmailRepo;
    @Autowired
    private MailProducer mailProducer;
    @Autowired
    private AccountRepo accountRepo;

    @Override
    public void save(String email){
        if(customerEmailRepo.existsByEmail(email)){
            throw new AlreadyExistException(email);
        }else {
            CustomerEmails customerMail = new CustomerEmails();
            customerMail.setEmail(email);
            customerEmailRepo.save(customerMail);

            mailProducer.send(MailTemplate.builder()
                    .to(email)
                    .subject("<Torano> Đăng ký nhận tin qua email")
                    .body("Bạn đã đăng ký nhận tin tức qua email thành công. Shop sẽ gửi thông tin tới bạn khi có chương trình khuyến mãi")
                    .build());
        }
    }


    @Override
    public void sendEmail(EmailTemplate emailTemplate) {
        List<CustomerEmails> customerMailList = customerEmailRepo.findAll();
        List<Account> accounts = accountRepo.findAll();
        List<String> listEmail = new ArrayList<>();

        for (Account account : accounts) {
            listEmail.add(account.getEmail());
        }

        for (CustomerEmails customerMail : customerMailList) {
            listEmail.add(customerMail.getEmail());
        }

        for (String email : listEmail) {
            mailProducer.send(MailTemplate.builder()
                    .to(email)
                    .subject(emailTemplate.getSubject())
                    .body(emailTemplate.getContent())
                    .build());
        }
    }
}
