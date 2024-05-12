package org.example.fashion_api.Services.InvoiceService;

import org.example.fashion_api.Models.Invoices.CreateInvoiceDto;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.Invoices.InvoiceRes;
import org.example.fashion_api.Models.Invoices.PageInvoiceRes;
import org.mapstruct.MappingTarget;

public interface InvoiceService {

    PageInvoiceRes getAllInvoices(String keyword, int page, int pageSize);

    InvoiceRes createInvoice(CreateInvoiceDto createInvoiceDto);

    InvoiceRes getById(String invoiceId);

    void updateShippingFee(String invoiceId, Long shippingFee);

}
