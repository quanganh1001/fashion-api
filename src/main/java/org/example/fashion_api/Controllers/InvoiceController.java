package org.example.fashion_api.Controllers;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.apache.http.HttpRequest;
import org.apache.http.client.methods.HttpTrace;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Invoices.*;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.example.fashion_api.Services.ColorService.ColorService;
import org.example.fashion_api.Services.InvoiceDetailService.InvoiceDetailService;
import org.example.fashion_api.Services.InvoiceService.InvoiceService;
import org.example.fashion_api.Services.VnpayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("invoices")
public class InvoiceController {
    @Autowired
    private InvoiceService invoiceService;
    @Autowired
    private InvoiceDetailService invoiceDetailService;

    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping()
    public ResponseEntity<PageInvoiceRes> findAll(@RequestParam(defaultValue = "1") int page,
                                  @RequestParam(defaultValue = "10") int pageSize,
                                  @RequestParam(defaultValue = "") String keyword){
        return ResponseEntity.ok(invoiceService.getAllInvoices(keyword, page-1, pageSize));
    }

    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("{invoiceId}")
    public ResponseEntity<InvoiceRes> findById(@PathVariable Long invoiceId){
        return ResponseEntity.ok(invoiceService.getById(invoiceId));
    }

    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("{invoiceId}/invoicesDetail")
    public ResponseEntity<List<InvoiceDetailRes>> findInvoiceDetailByInvoiceId(@PathVariable Long invoiceId){
        return ResponseEntity.ok(invoiceDetailService.getAllInvoicesDetailsByInvoice(invoiceId));
    }

    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @PostMapping
    public ResponseEntity<InvoiceRes> createInvoice(@Valid @RequestBody CreateInvoiceDto createInvoiceDto){
        return ResponseEntity.ok(invoiceService.createInvoice(createInvoiceDto));
    }

    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @PostMapping("/{invoiceId}/createInvoiceDetail")
    public ResponseEntity<InvoiceDetailRes> createInvoiceDetail(@PathVariable Long invoiceId,Long productDetailId) {
        return ResponseEntity.ok(invoiceDetailService.createInvoiceDetail(invoiceId,productDetailId));
    }

    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @PostMapping("/{invoiceId}/updateShippingFee")
    public ResponseEntity<String> updateShippingFee(@PathVariable Long invoiceId, Long shippingFee){
        invoiceService.updateShippingFee(invoiceId,shippingFee);
        return ResponseEntity.ok("Updated shipping fee successfully");
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{invoiceId}")
    public ResponseEntity<String> deleteInvoice(@PathVariable Long invoiceId){
        invoiceService.deleteInvoice(invoiceId);
        return ResponseEntity.ok("Invoice deleted successfully");
    }


    @PostMapping("/checkout")
    public ResponseEntity<String> checkout(HttpServletRequest http, @RequestBody CheckoutDto checkoutDto){
        String vnpayUrl = invoiceService.checkout(http,checkoutDto);

        return ResponseEntity.ok(vnpayUrl);
    }


}
