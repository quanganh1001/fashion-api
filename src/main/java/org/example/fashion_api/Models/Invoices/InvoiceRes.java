package org.example.fashion_api.Models.Invoices;

import lombok.*;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class InvoiceRes {
    private Long id;

    private String invoiceCode;

    private String name;

    private String phone;

    private String address;

    private String note;

    private String customerNote;

    private Long totalPrice;

    private Long shippingFee;

    private Long totalBill;

    private Boolean isPaid;

    private InvoiceStatusEnum invoiceStatus;

    private LocalDateTime createdAt;

    private Long accountId;

    private String accountName;

    private String store;

    private List<InvoiceDetailRes> invoicesDetails;

}
