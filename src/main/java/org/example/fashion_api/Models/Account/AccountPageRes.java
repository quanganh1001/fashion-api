package org.example.fashion_api.Models.Account;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Builder
public class AccountPageRes {

    private List<AccountRes> accountsRes;

    private int totalPages;
}
