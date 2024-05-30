package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Services.InvoiceDetailService.InvoiceDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("invoicesDetail")
@PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
public class InvoiceDetailController {
    @Autowired
    private InvoiceDetailService invoiceDetailService;

    @Operation(summary = "get invoice detail (role MANAGER,EMPLOYEE)")
    @GetMapping("/{invoiceDetailId}")
    public ResponseEntity<InvoiceDetailRes> getInvoiceDetail(@PathVariable Long invoiceDetailId) {
        return ResponseEntity.ok(invoiceDetailService.getById(invoiceDetailId));
    }

    @Operation(summary = "update shipping fee (role MANAGER,EMPLOYEE)")
    @PutMapping("/{invoiceDetailId}/changeQuantity")
    public ResponseEntity<String> updateQuantity(@PathVariable Long invoiceDetailId, int quantity){
        invoiceDetailService.changeQuantity(invoiceDetailId,quantity);
        return ResponseEntity.ok("Change quantity successfully");
    }

    @Operation(summary = "delete invoice detail (role MANAGER,EMPLOYEE)")
    @DeleteMapping("/{invoiceDetailId}")
    public ResponseEntity<String> deleteInvoiceDetail(@PathVariable Long invoiceDetailId){
        invoiceDetailService.deleteInvoiceDetail(invoiceDetailId);
        return ResponseEntity.ok("Delete successfully");
    }
}