package org.example.fashion_api.Models.InvoicesDetails;

import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.*;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class InvoiceDetailDto {
    private String invoiceId;

    private Long price;

    private Integer quantity;

    private Long productDetailId;
}
