package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.apache.http.HttpRequest;
import org.apache.http.client.methods.HttpTrace;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Invoices.*;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Models.InvoicesHistory.InvoiceHistoryRes;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.example.fashion_api.Services.ColorService.ColorService;
import org.example.fashion_api.Services.InvoiceDetailService.InvoiceDetailService;
import org.example.fashion_api.Services.InvoiceHistoryService.InvoiceHistoryService;
import org.example.fashion_api.Services.InvoiceService.InvoiceService;
import org.example.fashion_api.Services.VnpayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("invoices")
@RequiredArgsConstructor
public class InvoiceController {

    private final InvoiceService invoiceService;
    private final InvoiceDetailService invoiceDetailService;
    private final InvoiceHistoryService invoiceHistoryService;

    @Operation(summary = "get all Invoices Online (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("/online")
    public ResponseEntity<PageInvoiceRes> findAllOnline(@RequestParam(defaultValue = "1") int page,
                                  @RequestParam(defaultValue = "10") int limit,
                                  @RequestParam(defaultValue = "") String keyword,
                                  @RequestParam(required = false) Long accountId,
                                  @RequestParam(required = false) InvoiceStatusEnum invoiceStatus){
        return ResponseEntity.ok(invoiceService.getAllInvoicesOnline(keyword, page-1, limit, accountId, invoiceStatus));
    }

    @Operation(summary = "get all Invoices At Store (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("/store")
    public ResponseEntity<PageInvoiceRes> findAllAtStore(@RequestParam(defaultValue = "1") int page,
                                                  @RequestParam(defaultValue = "10") int limit,
                                                  @RequestParam(defaultValue = "") String keyword,
                                                  @RequestParam(defaultValue = "0") Long orderSource){
        return ResponseEntity.ok(invoiceService.getAllInvoicesAtStore(keyword, page-1, limit, orderSource));
    }

    @Operation(summary = "get Invoice (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("/online/{invoiceId}")
    public ResponseEntity<InvoiceRes> getInvoiceOnlineById(@PathVariable Long invoiceId){
        return ResponseEntity.ok(invoiceService.getInvoiceOnlineById(invoiceId));
    }

    @Operation(summary = "get Invoice (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("/store/{invoiceId}")
    public ResponseEntity<InvoiceRes> getInvoiceAtStoreById(@PathVariable Long invoiceId,@RequestParam Long store){
        return ResponseEntity.ok(invoiceService.getInvoiceAtStoreById(invoiceId,store));
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

    @PostMapping("/checkoutByCash")
    @Operation(summary = "checkout order", description = "accountId is the id of the employee who will be in charge of the order")
    public ResponseEntity<String> checkoutByCash(@Valid @RequestBody CheckoutDto checkoutDto){
        try {
             return ResponseEntity.ok(invoiceService.checkoutByCash(checkoutDto));
        }catch (Exception e) {
            return ResponseEntity.ok("http://localhost:3000/response?success=0");
        }
    }

    @PostMapping("/createInvoice")
    @Operation(summary = "create invoice", description = "create invoice at store")
    public void checkoutByCash(@Valid @RequestBody CreateInvoiceDto createInvoiceDto){
           invoiceService.createInvoiceAtStore(createInvoiceDto);
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
        return ResponseEntity.ok(invoiceService.updateInvoice(invoiceId,dto));
    }

    @Operation(summary = "show history (role MANAGER,EMPLOYEE)")
    @PreAuthorize("hasAnyRole('MANAGER','EMPLOYEE')")
    @GetMapping("history/{invoiceId}")
    public ResponseEntity<List<InvoiceHistoryRes>> showHistory(@PathVariable Long invoiceId){
        return ResponseEntity.ok(invoiceHistoryService.getInvoiceHistory(invoiceId));
    }

    @Operation(summary = "View Purchased Orders  (auth)")
    @GetMapping("/viewPurchasedOrders")
    public ResponseEntity<PageInvoiceRes> viewPurchasedOrders(@RequestParam(defaultValue = "1") int page,
                                                              @RequestParam(defaultValue = "10") int limit){
        return ResponseEntity.ok(invoiceService.viewPurchasedOrders(page -1 ,limit));
    }
}
