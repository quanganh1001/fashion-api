package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface InvoiceRepo extends JpaRepository<Invoice,Long> {

    @Query(value = "SELECT * FROM invoices WHERE is_deleted = false AND (phone LIKE %:keyword% OR invoice_code LIKE %:keyword%)",
            nativeQuery = true)
    Page<Invoice> searchInvoices(@Param("keyword") String keyword, Pageable pageable);


    @Query(value = "SELECT * FROM invoices  WHERE is_deleted = false AND account_id = :accountId AND (phone LIKE " +
            "%:keyword% OR invoice_code LIKE %:keyword%)",
            nativeQuery = true)
    Page<Invoice> searchInvoicesByAccount(@Param("accountId") Long accountId, @Param("keyword") String keyword,
                                  Pageable pageable);

    @Modifying
    @Query(value = "UPDATE invoices SET is_paid = TRUE WHERE id = :invoiceId",
            nativeQuery = true)
    void changeStatusIsPaid(@Param("invoiceId") Long invoiceId);

    @Modifying
    @Query(value = "UPDATE invoices SET invoice_status = :status WHERE id = :invoiceId",
            nativeQuery = true)
    void changeStatusInvoice(@Param("invoiceId") Long invoiceId,@Param("status") int status);
}
