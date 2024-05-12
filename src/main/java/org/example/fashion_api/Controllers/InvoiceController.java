package org.example.fashion_api.Controllers;

import jakarta.validation.Valid;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Invoices.PageInvoiceRes;
import org.example.fashion_api.Services.ColorService.ColorService;
import org.example.fashion_api.Services.InvoiceService.InvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("invoices")
@PreAuthorize("hasAnyRole('MANAGER')")
public class InvoiceController {
    @Autowired
    private InvoiceService invoiceService;

    @GetMapping()
    public PageInvoiceRes findAll(@RequestParam(defaultValue = "1") int page,
                                  @RequestParam(defaultValue = "10") int pageSize,
                                  @RequestParam(defaultValue = "") String keyword){
        return invoiceService.getAllInvoices(keyword, page, pageSize);
    }


    @GetMapping("{invoiceId}")
    public PageInvoiceRes findById(@RequestParam(defaultValue = "1") int page,
                                  @RequestParam(defaultValue = "10") int pageSize,
                                  @RequestParam(defaultValue = "") String keyword){
        return invoiceService.getAllInvoices(keyword, page, pageSize);
    }
}
