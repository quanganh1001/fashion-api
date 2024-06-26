package org.example.fashion_api.Mapper;


import org.example.fashion_api.Models.Accounts.*;
import org.mapstruct.Mapper;

import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper {
    Account accountRegisterDtoToAccount(AccountRegisterDto accountRegisterDto, @MappingTarget Account account);

    @Mapping(target = "id", source = "id")
    AccountRes accountEntityToAccountRes(Account account);

    List<AccountRes> accountsToListAccountRes(List<Account> accounts);


    Account accountUpdateDtoToAccount(AccountUpdateDto accountUpdateDto, @MappingTarget Account account);


    Account createAccountDtoToAccount(CreateAccountDto createAccountDto, @MappingTarget Account account);

}
