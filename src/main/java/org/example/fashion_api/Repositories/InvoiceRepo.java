package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface InvoiceRepo extends JpaRepository<Invoice,String> {
    Page<Invoice> findAllByPhoneContainingIgnoreCaseOrInvoiceIdContainingIgnoreCase(String keyword, String keyword2, PageRequest pageRequest);

    @Modifying
    @Query(value = "UPDATE invoices SET is_paid = TRUE WHERE invoice_id = :invoiceId",
            nativeQuery = true)
    void changeStatusIsPaid(@Param("invoiceId") String invoiceId);

}
