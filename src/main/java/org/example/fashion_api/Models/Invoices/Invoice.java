package org.example.fashion_api.Models.Invoices;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.apache.commons.lang3.RandomStringUtils;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.StoresAddress.StoresAddress;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@NoArgsConstructor(force = true)
@AllArgsConstructor
@Builder
@Table(name = "invoices")
public class Invoice extends BaseEntity {
    @NotNull
    private String invoiceCode;

    @NotNull
    private String name;

    @NotNull
    private String phone;

    @NotNull
    private String address;

    private String note;

    private String customerNote;

    @NotNull
    private Long totalPrice;

    @NotNull
    private Long shippingFee;

    @NotNull
    private Long totalBill;

    private LocalDateTime successfulDate;

    private LocalDateTime confirmationDate;

    private Boolean isPaid = Boolean.FALSE;

    @Enumerated(EnumType.STRING)
    private InvoiceStatusEnum invoiceStatus = InvoiceStatusEnum.NEW;

    private Boolean isDeleted = Boolean.FALSE;

    @ManyToOne
    @JoinColumn(name = "account_id")
    private Account account;

    @ManyToOne
    @JoinColumn(name = "order_source")
    private StoresAddress orderSource;

    @OneToMany(mappedBy = "invoice", cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<InvoiceDetail> invoicesDetails = new ArrayList<>();


    @PrePersist
    public void prePersist() {
        if(totalPrice == null)
            totalPrice = 0L;

        if (invoiceCode == null)
            invoiceCode = RandomStringUtils.randomAlphanumeric(8).toUpperCase();

        totalBill = totalPrice + shippingFee;

    }

}
