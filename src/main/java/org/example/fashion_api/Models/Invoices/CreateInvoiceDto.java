package org.example.fashion_api.Models.Invoices;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;

import java.util.List;

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

    private String note;

    private Long store;

    private List<InvoiceDetailDto> invoicesDetails;

}
