package org.example.fashion_api.Services.InvoiceService;

import jakarta.servlet.http.HttpServletRequest;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Models.Invoices.*;
import org.mapstruct.MappingTarget;

public interface InvoiceService {

    PageInvoiceRes getAllInvoices(String keyword, int page, int pageSize);

    InvoiceRes createInvoice(CreateInvoiceDto createInvoiceDto);

    InvoiceRes getById(Long invoiceId);

    void updateShippingFee(Long invoiceId, Long shippingFee);

    void deleteInvoice(Long invoiceId);

    String checkout(HttpServletRequest http, CheckoutDto checkoutDto);

    void updateStatus(Long invoiceId, InvoiceStatusEnum status);

    InvoiceRes updateInvoice(Long invoiceId, UpdateInvoiceDto dto);
}
