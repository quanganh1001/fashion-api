package org.example.fashion_api.Services.InvoiceHistoryService;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Models.InvoicesHistory.InvoiceHistoryRes;

import java.util.List;

public interface InvoiceHistoryService {
    List<InvoiceHistoryRes> getInvoiceHistory(Long invoiceId);

    void setNameVarForTrigger();
}
