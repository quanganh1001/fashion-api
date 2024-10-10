package org.example.fashion_api.Models.Invoices;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PageInvoiceRes {


    private Long totalItems;

    private int totalPages;

    private int currentPage;

    private List<InvoiceRes> invoices;
}
