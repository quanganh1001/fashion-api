package org.example.fashion_api.Controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Stored.SalesStored;
import org.example.fashion_api.Models.Stored.TopProductStored;
import org.example.fashion_api.Services.StoredService.StoredService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("stored")
public class StoredController {
    private final StoredService storedService;


    @Operation(summary = "Get best selling products by date")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @GetMapping("/topProduct")
    public ResponseEntity<List<TopProductStored>> selectTopProduct(@RequestParam LocalDate startDate,
                                                                   @RequestParam LocalDate endDate,
                                                                   @RequestParam(defaultValue = "-1") Long store) throws JsonProcessingException {
        return ResponseEntity.ok(storedService.findTopProduct(startDate,endDate,store));
    }

    @Operation(summary = "Get sales sent by date")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @GetMapping("/salesSent")
    public ResponseEntity<SalesStored> salesSent(@RequestParam LocalDate startDate,
                                                 @RequestParam LocalDate endDate) throws JsonProcessingException {
        return ResponseEntity.ok(storedService.findSalesSent(startDate,endDate));
    }

    @Operation(summary = "Get sales success by date")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @GetMapping("/salesSuccess")
    public ResponseEntity<SalesStored> salesSuccess(@RequestParam LocalDate startDate,
                                                 @RequestParam LocalDate endDate,
                                                    @RequestParam(defaultValue = "-1") Long store) throws JsonProcessingException {
        return ResponseEntity.ok(storedService.findSalesSuccess(startDate,endDate,store));
    }
}
