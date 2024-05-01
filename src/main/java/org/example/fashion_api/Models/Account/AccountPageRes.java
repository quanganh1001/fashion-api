package org.example.fashion_api.Models.Account;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AccountPageRes {

    private List<AccountRes> accountsRes;

    private int totalPages;


}
