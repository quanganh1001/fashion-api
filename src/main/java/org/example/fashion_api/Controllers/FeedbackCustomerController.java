package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import lombok.Getter;
import org.example.fashion_api.Models.FeedbackCustomers.FeedbackCustomer;
import org.example.fashion_api.Models.FeedbackCustomers.PageFeedbackCustomer;
import org.example.fashion_api.Services.FeedbackCustomerService.FeedbackCustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/feedback")
public class FeedbackCustomerController {
    @Autowired
    private FeedbackCustomerService feedbackCustomerService;

    @GetMapping("count")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "get count feedback unread")
    public ResponseEntity<Integer> getCountFeedbackUnread() {
        return ResponseEntity.ok(feedbackCustomerService.countUnread());
    }

    @GetMapping()
    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "get all feedbacks")
    public ResponseEntity<PageFeedbackCustomer> getAllFeedbackCustomers(@RequestParam(defaultValue = "1") int page,
                                                                        @RequestParam(defaultValue = "10") int limit) {
        return ResponseEntity.ok(feedbackCustomerService.findAll(page-1,limit));
    }

    @PutMapping("/read")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "read feedback")
    public ResponseEntity<String> setRead(@RequestBody Long id) {
        feedbackCustomerService.readFeedback(id);
        return ResponseEntity.ok("Successfully");
    }

    @PutMapping("/unread")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "unread feedback")
    public ResponseEntity<String> setUnread(@RequestBody Long id) {
        feedbackCustomerService.setUnread(id);
        return ResponseEntity.ok("Successfully unread");
    }

    @PostMapping
    public ResponseEntity<String> createFeedbackCustomer(@RequestBody FeedbackCustomer feedbackCustomer) {
        feedbackCustomerService.save(feedbackCustomer);
        return ResponseEntity.ok("Successfully created");
    }

}
