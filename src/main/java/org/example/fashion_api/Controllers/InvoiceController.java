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
@PreAuthorize("hasAnyRole('MANAGER')")
public class InvoiceController {
    @Autowired
    private InvoiceService invoiceService;
    @Autowired
    private InvoiceDetailService invoiceDetailService;
    @Autowired
    private VnpayService vnpayService;
    @Autowired
    private InvoiceRepo invoiceRepo;

    @GetMapping()
    public ResponseEntity<PageInvoiceRes> findAll(@RequestParam(defaultValue = "1") int page,
                                  @RequestParam(defaultValue = "10") int pageSize,
                                  @RequestParam(defaultValue = "") String keyword){
        return ResponseEntity.ok(invoiceService.getAllInvoices(keyword, page-1, pageSize));
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



    @PostMapping("/checkout")
    public ResponseEntity<String> checkout(HttpServletRequest http, @RequestBody CheckoutDto checkoutDto){

        CreateInvoiceDto createInvoiceDto = CreateInvoiceDto.builder()
                .accountId(checkoutDto.getAccountId())
                .address(checkoutDto.getAddress())
                .phone(checkoutDto.getPhone())
                .name(checkoutDto.getName())
                .customerNote(checkoutDto.getCustomerNote())
                .shippingFee(checkoutDto.getShippingFee())
                .build();
        InvoiceRes invoiceRes = invoiceService.createInvoice(createInvoiceDto);

        for (InvoiceDetailDto invoiceDetail: checkoutDto.getInvoicesDetails()){
            createInvoiceDetail(invoiceRes.getInvoiceId(),invoiceDetail.getProductDetailId());
        }

        Invoice invoice = invoiceRepo.findById(invoiceRes.getInvoiceId())
                .orElseThrow(()->new NotFoundException("Invoice not found"));

        String vnpayUrl = vnpayService.createPaymentUrl(http,invoiceRes.getInvoiceId(),invoice.getTotalBill());

        return ResponseEntity.ok(vnpayUrl);
    }
}
