package org.example.fashion_api.Models.Accounts;

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

    private int currenPage;

    private Long totalAccount;
}
