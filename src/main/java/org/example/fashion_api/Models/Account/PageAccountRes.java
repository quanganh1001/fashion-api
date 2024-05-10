package org.example.fashion_api.Models.Account;

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
