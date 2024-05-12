package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface InvoiceDetailRepo extends JpaRepository<InvoiceDetail,Long> {
    List<InvoiceDetail> findAllByInvoiceInvoiceId(String invoiceId);
}
