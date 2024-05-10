package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Invoices.Invoice;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InvoiceRepo extends JpaRepository<Invoice,String> {
    Page<Invoice> findAllByPhoneContainingIgnoreCaseOrInvoiceIdContainingIgnoreCase(String keyword, String keyword2, PageRequest pageRequest);
}
