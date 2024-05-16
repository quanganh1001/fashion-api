package org.example.fashion_api.Models.Invoices;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.example.fashion_api.Enum.InvoiceStatusEnum;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UpdateInvoiceDto {
    @NotNull
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
}
