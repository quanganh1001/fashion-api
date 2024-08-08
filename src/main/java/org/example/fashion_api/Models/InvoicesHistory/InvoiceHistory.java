package org.example.fashion_api.Models.InvoicesHistory;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;

import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
@Table(name = "invoices_history")
public class InvoiceHistory extends BaseEntity {

    private String content;

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;


}
