package org.example.fashion_api.Models.AccountsAdmin;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PageAccountRes {

    private List<AccountRes> accountsRes;

    private int totalPages;

    private int currentPage;

    private Long totalItems;
}
