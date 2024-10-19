//package org.example.SendMailApplication.Controller;
//
//import lombok.RequiredArgsConstructor;
//import org.example.SendMailApplication.Consumer.MailConsumer;
//import org.example.SendMailApplication.Models.MailTemplate;
//import org.example.SendMailApplication.Producer.MailProducer;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestHeader;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//@RestController
//@RequiredArgsConstructor
//@RequestMapping("sendMail")
//public class SendMailController {
//
//    private final MailConsumer mailConsumer;
//
//    @GetMapping
//    public ResponseEntity<Void> sendMail(MailTemplate mailTemplate,
//                                         @RequestHeader(value = "Internal-Access-Token") String accessToken) {
//        // Kiểm tra token nội bộ
//        if (!"VDSDCXCVX".equals(accessToken)) {
//            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
//        }
//        try {
//            mailConsumer.(mailTemplate);
//            return ResponseEntity.ok().build();
//        }catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//
//    }
//}
