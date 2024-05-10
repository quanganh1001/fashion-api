package org.example.fashion_api.Mapper;


import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.Accounts.AccountRegisterDto;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Models.Accounts.AccountUpdateDto;
import org.mapstruct.Mapper;

import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper {
    Account accountRegisterDtoToAccount(AccountRegisterDto accountRegisterDto, @MappingTarget Account account);

    @Mapping(target = "accountId", source = "accountId")
    AccountRes accountEntityToAccountRes(Account account);

    List<AccountRes> accountsToListAccountRes(List<Account> accounts);


    Account accountUpdateDtoToAccount(AccountUpdateDto accountUpdateDto, @MappingTarget Account account);

}
