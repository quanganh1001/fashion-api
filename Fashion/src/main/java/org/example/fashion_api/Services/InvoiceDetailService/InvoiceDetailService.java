package org.example.fashion_api.Services.InvoiceDetailService;

import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;

import java.util.List;

public interface InvoiceDetailService {

    List<InvoiceDetailRes> getAllInvoicesDetailsByInvoice(Long invoiceId);

    InvoiceDetailRes getById(Long invoiceDetailId);

    InvoiceDetailRes createInvoiceDetail(Long invoiceId, Long productDetailId,int quantity);

    void changeQuantity(Long invoiceDetailId, int quantity);

    void deleteInvoiceDetail(Long invoiceDetailId);
}
