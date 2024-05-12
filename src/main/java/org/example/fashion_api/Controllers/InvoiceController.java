package org.example.fashion_api.Controllers;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Invoices.CheckoutDto;
import org.example.fashion_api.Models.Invoices.CreateInvoiceDto;
import org.example.fashion_api.Models.Invoices.InvoiceRes;
import org.example.fashion_api.Models.Invoices.PageInvoiceRes;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Services.ColorService.ColorService;
import org.example.fashion_api.Services.InvoiceDetailService.InvoiceDetailService;
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
    @Autowired
    private InvoiceDetailService invoiceDetailService;

    @GetMapping()
    public ResponseEntity<PageInvoiceRes> findAll(@RequestParam(defaultValue = "1") int page,
                                  @RequestParam(defaultValue = "10") int pageSize,
                                  @RequestParam(defaultValue = "") String keyword){
        return ResponseEntity.ok(invoiceService.getAllInvoices(keyword, page, pageSize));
    }

    @GetMapping("{invoiceId}")
    public ResponseEntity<InvoiceRes> findById(@PathVariable String invoiceId){
        return ResponseEntity.ok(invoiceService.getById(invoiceId));
    }

    @GetMapping("{invoiceId}/invoicesDetail")
    public ResponseEntity<List<InvoiceDetailRes>> findInvoiceDetailByInvoiceId(@PathVariable String invoiceId){
        return ResponseEntity.ok(invoiceDetailService.getAllInvoicesDetailsByInvoice(invoiceId));
    }

    @PostMapping
    public ResponseEntity<InvoiceRes> createInvoice(@Valid @RequestBody CreateInvoiceDto createInvoiceDto){
        return ResponseEntity.ok(invoiceService.createInvoice(createInvoiceDto));
    }

    @PostMapping("/{invoiceId}/createInvoiceDetail")
    public ResponseEntity<InvoiceDetailRes> createInvoiceDetail(@PathVariable String invoiceId,Long productDetailId) {
        return ResponseEntity.ok(invoiceDetailService.createInvoiceDetail(invoiceId,productDetailId));
    }


    @PostMapping("/{invoiceId}/updateShippingFee")
    public ResponseEntity<String> updateShippingFee(@PathVariable String invoiceId, Long shippingFee){
        invoiceService.updateShippingFee(invoiceId,shippingFee);
        return ResponseEntity.ok("Updated shipping fee successfully");
    }



//    @PostMapping()
//    public ResponseEntity<String> checkout(CheckoutDto checkoutDto){
//        checkoutDto.
//    }
}
