package org.example.fashion_api.Models.InvoicesDetails;

import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.Invoices.InvoiceRes;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class InvoiceDetailRes {

    private Long id;

    private Long price;

    private Integer quantity;

    private Long totalPrice;

    private String code;

    private String productName;

    private String invoiceId;

}
