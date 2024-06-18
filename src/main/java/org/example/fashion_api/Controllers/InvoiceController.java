package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.apache.http.HttpRequest;
import org.apache.http.client.methods.HttpTrace;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
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

    @Operation(summary = "get all Invoices (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping()
    public ResponseEntity<PageInvoiceRes> findAll(@RequestParam(defaultValue = "1") int page,
                                  @RequestParam(defaultValue = "10") int pageSize,
                                  @RequestParam(defaultValue = "") String keyword,
                                  @RequestParam(required = false) Long accountId,
                                  @RequestParam(required = false) InvoiceStatusEnum invoiceStatus){
        return ResponseEntity.ok(invoiceService.getAllInvoices(keyword, page-1, pageSize, accountId, invoiceStatus));
    }

    @Operation(summary = "get Invoice (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("{invoiceId}")
    public ResponseEntity<InvoiceRes> findById(@PathVariable Long invoiceId){
        return ResponseEntity.ok(invoiceService.getById(invoiceId));
    }


    @Operation(summary = "get all Invoice Detail by invoiceId (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("{invoiceId}/invoicesDetail")
    public ResponseEntity<List<InvoiceDetailRes>> findInvoiceDetailByInvoiceId(@PathVariable Long invoiceId){
        return ResponseEntity.ok(invoiceDetailService.getAllInvoicesDetailsByInvoice(invoiceId));
    }



    @Operation(summary = "create Invoice detail (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @PostMapping("/{invoiceId}/createInvoiceDetail")
    public ResponseEntity<InvoiceDetailRes> createInvoiceDetail(@PathVariable Long invoiceId,Long productDetailId) {
        return ResponseEntity.ok(invoiceDetailService.createInvoiceDetail(invoiceId,productDetailId));
    }

    @Operation(summary = "update shipping fee (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @PutMapping("/{invoiceId}/updateShippingFee")
    public ResponseEntity<String> updateShippingFee(@PathVariable Long invoiceId, Long shippingFee){
        invoiceService.updateShippingFee(invoiceId,shippingFee);
        return ResponseEntity.ok("Updated shipping fee successfully");
    }

    @Operation(summary = "delete invoice (role MANAGER)")
    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{invoiceId}")
    public ResponseEntity<String> deleteInvoice(@PathVariable Long invoiceId){
        invoiceService.deleteInvoice(invoiceId);
        return ResponseEntity.ok("Invoice deleted successfully");
    }


    @PostMapping("/checkout")
    @Operation(summary = "checkout order", description = "accountId is the id of the employee who will be in charge of the order")
    public ResponseEntity<String> checkout(HttpServletRequest http,@Valid @RequestBody CheckoutDto checkoutDto){
        String vnpayUrl = invoiceService.checkout(http,checkoutDto);

        return ResponseEntity.ok(vnpayUrl);
    }


    @Operation(summary = "update status invoice (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @PutMapping("/{invoiceId}/updateStatus")
    public ResponseEntity<String> updateStatus(@PathVariable Long invoiceId,
                                              @RequestBody InvoiceStatusEnum statusEnum){
        invoiceService.updateStatus(invoiceId,statusEnum);
        return ResponseEntity.ok("Updated status successfully");
    }


    @Operation(summary = "update invoice (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @PutMapping("/{invoiceId}")
    public ResponseEntity<InvoiceRes> updateInvoice(@PathVariable Long invoiceId,
                                               @Valid @RequestBody UpdateInvoiceDto dto){
        System.out.println(dto.getIsPaid());
        return ResponseEntity.ok(invoiceService.updateInvoice(invoiceId,dto));
    }
}
