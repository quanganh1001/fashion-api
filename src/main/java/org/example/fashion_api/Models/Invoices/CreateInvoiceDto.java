package org.example.fashion_api.Models.Invoices;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateInvoiceDto {
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

    private Long accountId;
}
