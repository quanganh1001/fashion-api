package org.example.fashion_api.Models.Invoices;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PageInvoiceRes {
    private List<InvoiceRes> invoices;

    private Long totalInvoices;

    private int totalPages;

    private int currentPage;
}
