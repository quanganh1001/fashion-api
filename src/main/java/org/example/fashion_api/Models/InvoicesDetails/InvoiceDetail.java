package org.example.fashion_api.Models.InvoicesDetails;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;

@Entity
@Data
@NoArgsConstructor(force = true)
@AllArgsConstructor
@Builder
@Table(name = "invoices_detail")
public class InvoiceDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long detailId;
    private Long price;
    private Integer quantity;
    private Long totalPrice;

    @ManyToOne
    @JoinColumn(name = "product_detail_id")
    private ProductDetail productDetail;

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;
}
