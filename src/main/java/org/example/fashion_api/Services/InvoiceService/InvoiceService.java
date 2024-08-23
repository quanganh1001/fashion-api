package org.example.fashion_api.Services.InvoiceService;

import jakarta.servlet.http.HttpServletRequest;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Models.Invoices.*;
import org.mapstruct.MappingTarget;
import org.springframework.data.domain.Page;

import java.util.List;

public interface InvoiceService {

    PageInvoiceRes getAllInvoicesOnline(String keyword, int page, int pageSize,Long accountId, InvoiceStatusEnum invoiceStatus);

    InvoiceRes createInvoice(CheckoutDto checkoutDto);

    String checkoutByCash(CheckoutDto checkoutDto);

    InvoiceRes getInvoiceOnlineById(Long invoiceId);

    InvoiceRes getInvoiceAtStoreById(Long invoiceId,Long store);

    void updateShippingFee(Long invoiceId, Long shippingFee);

    void deleteInvoice(Long invoiceId);

    String checkout(HttpServletRequest http, CheckoutDto checkoutDto);

    void updateStatus(Long invoiceId, InvoiceStatusEnum status);

    InvoiceRes updateInvoice(Long invoiceId, UpdateInvoiceDto dto);

    PageInvoiceRes viewPurchasedOrders(int page,int limit);

    PageInvoiceRes getAllInvoicesAtStore(String keyword, int i, int limit, Long orderSource);

    void createInvoiceAtStore(CreateInvoiceDto createInvoiceDto);
}
