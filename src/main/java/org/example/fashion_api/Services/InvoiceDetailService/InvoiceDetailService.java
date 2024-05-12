package org.example.fashion_api.Services.InvoiceDetailService;

import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;

import java.util.List;

public interface InvoiceDetailService {

    List<InvoiceDetailRes> getAllInvoicesDetailsByInvoice(String invoiceId);

    InvoiceDetailRes getById(Long invoiceDetailId);

    InvoiceDetailRes createInvoiceDetail(String invoiceId, Long productDetailId);

    void changeQuantity(Long invoiceDetailId, int quantity);
}
