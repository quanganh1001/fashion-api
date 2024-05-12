package org.example.fashion_api.Services.InvoiceDetailService;

import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;

import java.util.List;

public interface InvoiceDetailService {

    List<InvoiceDetailRes> getAllInvoicesDetailsByInvoice(String invoiceId);
}
