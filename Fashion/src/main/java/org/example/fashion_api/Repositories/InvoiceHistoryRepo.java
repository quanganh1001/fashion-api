package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.InvoicesHistory.InvoiceHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InvoiceHistoryRepo extends JpaRepository<InvoiceHistory, Integer> {
    List<InvoiceHistory> findByInvoiceId(Long invoiceId);
}
