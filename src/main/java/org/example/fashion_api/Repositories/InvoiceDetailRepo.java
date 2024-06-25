package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InvoiceDetailRepo extends JpaRepository<InvoiceDetail,Long> {
    List<InvoiceDetail> findAllByInvoiceId(Long invoiceId);

    InvoiceDetail findByInvoiceIdAndProductDetailId(Long invoiceId,Long productDetailId);


}
