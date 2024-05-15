package org.example.fashion_api.Models.Invoices;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import org.apache.commons.lang3.RandomStringUtils;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@NoArgsConstructor(force = true)
@AllArgsConstructor
@Builder
@Table(name = "invoices")
public class Invoice extends BaseEntity {

    private String invoiceCode;

    @NotBlank(message = "Tên không được để trống")
    private String name;

    @Pattern(regexp = "^[0-9]{10}$", message = "Số điện thoại không đúng")
    private String phone;

    @NotBlank(message = "Địa chỉ không được để trống")
    private String address;

    private String note;

    private String customerNote;

    @NotNull
    private Long totalPrice;

    @NotNull
    private Long shippingFee;

    @NotNull
    private Long totalBill;

    private Boolean isPaid = Boolean.FALSE;

    private InvoiceStatusEnum invoiceStatus = InvoiceStatusEnum.NEW;

    private Boolean isDeleted = Boolean.FALSE;

    @ManyToOne
    @JoinColumn(name = "account_id")
    private Account account;

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
