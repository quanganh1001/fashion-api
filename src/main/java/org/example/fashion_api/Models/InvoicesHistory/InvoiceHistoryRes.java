package org.example.fashion_api.Models.InvoicesHistory;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class InvoiceHistoryRes {
    private String content;

    private String createAt;
}
