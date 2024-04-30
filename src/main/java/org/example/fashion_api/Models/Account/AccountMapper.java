package org.example.fashion_api.Models.Account;


import org.mapstruct.Mapper;

import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;
import org.springframework.data.domain.Page;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper {
    Account accountRegisterDtoToAccount(AccountRegisterDto accountRegisterDto, @MappingTarget Account account);

    AccountRes accountEntityToAccountRes(Account account);

    List<AccountRes> accountsToListAccountRes(List<Account> accounts);


    Account accountUpdateDtoToAccount(AccountUpdateDto accountUpdateDto, @MappingTarget Account account);

}
