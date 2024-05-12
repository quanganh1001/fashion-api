package org.example.fashion_api.Controllers;

import lombok.Getter;
import org.example.fashion_api.Models.Invoices.PageInvoiceRes;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Services.InvoiceDetailService.InvoiceDetailService;
import org.example.fashion_api.Services.InvoiceService.InvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("invoicesDetail")
@PreAuthorize("hasAnyRole('MANAGER')")
public class InvoiceDetailController {
    @Autowired
    private InvoiceDetailService invoiceDetailService;

    @GetMapping("/{invoiceDetailId}")
    public ResponseEntity<InvoiceDetailRes> getInvoiceDetail(@PathVariable Long invoiceDetailId) {
        return ResponseEntity.ok(invoiceDetailService.getById(invoiceDetailId));
    }

    @PutMapping("/{invoiceDetailId}/changeQuantity")
    public ResponseEntity<String> updateShippingFee(@PathVariable Long invoiceDetailId, int quantity){
        invoiceDetailService.changeQuantity(invoiceDetailId,quantity);
        return ResponseEntity.ok("Change quantity successfully");
    }
}