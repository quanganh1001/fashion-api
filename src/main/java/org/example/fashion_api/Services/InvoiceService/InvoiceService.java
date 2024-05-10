package org.example.fashion_api.Services.InvoiceService;

import org.example.fashion_api.Models.Invoices.PageInvoiceRes;

public interface InvoiceService {

    PageInvoiceRes getAllInvoices(String keyword, int page, int pageSize);
}
