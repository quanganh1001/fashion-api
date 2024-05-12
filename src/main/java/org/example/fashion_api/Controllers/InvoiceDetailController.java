package org.example.fashion_api.Controllers;

import org.example.fashion_api.Models.Invoices.PageInvoiceRes;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Services.InvoiceDetailService.InvoiceDetailService;
import org.example.fashion_api.Services.InvoiceService.InvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("invoicesDetails")
@PreAuthorize("hasAnyRole('MANAGER')")
public class InvoiceDetailController {
    @Autowired
    private InvoiceDetailService invoiceDetailService;

    @GetMapping()
    public List<InvoiceDetailRes> findAllByInvoice(@RequestParam String invoiceId){
        return invoiceDetailService.getAllInvoicesDetailsByInvoice(invoiceId);
    }

}