package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InvoiceDetailRepo extends JpaRepository<InvoiceDetail,Long> {
}