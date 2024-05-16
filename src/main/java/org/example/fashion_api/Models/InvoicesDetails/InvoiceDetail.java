package org.example.fashion_api.Models.InvoicesDetails;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.RandomStringUtils;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;

@Entity
@Data
@NoArgsConstructor(force = true)
@AllArgsConstructor
@Builder
@Table(name = "invoices_detail")
public class InvoiceDetail extends BaseEntity {

    private Long price;

    private Integer quantity;

    private Long totalPrice;

    @ManyToOne
    @JoinColumn(name = "product_detail_id")
    private ProductDetail productDetail;

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;

    @PrePersist
    public void prePersist() {
        totalPrice = price * quantity;
    }

    @PreUpdate
    public void preUpdate() {
        totalPrice = price * quantity;
    }
}
