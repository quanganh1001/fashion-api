package org.example.fashion_api.Models.Invoices;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;

import java.util.List;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CheckoutDto {
    @NotBlank(message = "Tên không được để trống")
    private String name;

    @Pattern(regexp = "^[0-9]{10}$", message = "Số điện thoại không đúng")
    private String phone;

    @NotBlank(message = "Địa chỉ không được để trống")
    private String address;

    private String customerNote;

    private Long shippingFee;

    private List<InvoiceDetailDto> invoicesDetails;
}
