package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.Invoices.Invoice;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface InvoiceRepo extends JpaRepository<Invoice,Long> {

    @Query(value = "SELECT * FROM invoices WHERE (is_deleted = false) AND ((phone LIKE %:keyword%) OR (invoice_code " +
            "LIKE %:keyword%)) AND (order_source IS NULL)",
            nativeQuery = true)
    Page<Invoice> searchInvoicesOnline(@Param("keyword") String keyword, Pageable pageable);


    @Query(value = "SELECT * FROM invoices WHERE is_deleted = false AND " +
            "(account_id = :accountId OR (:accountId IS NULL AND account_id IS NULL)) " +
            "AND (phone LIKE %:keyword% OR invoice_code LIKE %:keyword%) AND order_source IS NULL",
            nativeQuery = true)
    Page<Invoice> searchInvoicesByAccountOnline(@Param("accountId") Long accountId, @Param("keyword") String keyword,
                                                Pageable pageable);

    @Query(value = "SELECT * FROM invoices WHERE is_deleted = false AND invoice_status = :statusEnum AND (phone LIKE %:keyword% OR invoice_code LIKE %:keyword%) AND order_source IS NULL ",
            nativeQuery = true)
    Page<Invoice> searchInvoicesWithStatusOnline(@Param("keyword") String keyword, @Param("statusEnum") String statusEnum, Pageable pageable);

    @Query(value = "SELECT * FROM invoices WHERE is_deleted = false AND account_id = :accountId AND invoice_status = :statusEnum AND (phone LIKE %:keyword% OR invoice_code LIKE %:keyword%) AND order_source IS NULL",
            nativeQuery = true)
    Page<Invoice> searchInvoicesByAccountWithStatusOnline(@Param("accountId") Long accountId, @Param("keyword") String keyword, @Param("statusEnum") String statusEnum, Pageable pageable);


    @Modifying
    @Query(value = "UPDATE invoices SET is_paid = TRUE WHERE id = :invoiceId",
            nativeQuery = true)
    void changeStatusIsPaid(@Param("invoiceId") Long invoiceId);

    @Modifying
    @Query(value = "UPDATE invoices SET invoice_status = :status WHERE id = :invoiceId",
            nativeQuery = true)
    void changeStatusInvoice(@Param("invoiceId") Long invoiceId,@Param("status") String status);

    Optional<Invoice> findByIdAndOrderSourceIsNull(Long id);

    Page<Invoice> findAllByPhoneOrderByCreatedAtDesc(String phone, Pageable pageable);

    @Query(value = "SELECT * FROM invoices WHERE (is_deleted = false) AND ((phone LIKE %:keyword%) OR (invoice_code " +
            "LIKE %:keyword%)) AND (order_source = :orderSource)",
            nativeQuery = true)
    Page<Invoice> searchInvoicesByStore(@Param("keyword") String keyword,@Param("orderSource") Long orderSource, Pageable pageable);

    @Query(value = "SELECT * FROM invoices WHERE is_deleted = false AND (LOWER(phone) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(invoice_code) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND (order_source IS NOT NULL)",
            nativeQuery = true)
    Page<Invoice> searchAllInvoicesAtStore(@Param("keyword") String keyword, Pageable pageable);


    Optional<Invoice> findByIdAndOrderSourceId(Long id,Long store);
}
