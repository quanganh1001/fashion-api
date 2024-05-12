package org.example.fashion_api.Models.Invoices;

import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class InvoiceRes {

    private String invoiceId;

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

    private List<InvoiceDetailRes> invoicesDetails;
}
