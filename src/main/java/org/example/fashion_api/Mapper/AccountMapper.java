package org.example.fashion_api.Mapper;


import org.example.fashion_api.Models.AccountsAdmin.*;
import org.mapstruct.Mapper;

import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AccountMapper {
    AccountAdmin accountRegisterDtoToAccount(AccountRegisterDto accountRegisterDto, @MappingTarget AccountAdmin accountAdmin);

    @Mapping(target = "id", source = "id")
    AccountRes accountEntityToAccountRes(AccountAdmin accountAdmin);

    List<AccountRes> accountsToListAccountRes(List<AccountAdmin> accountAdmins);


    AccountAdmin accountUpdateDtoToAccount(AccountUpdateDto accountUpdateDto, @MappingTarget AccountAdmin accountAdmin);


    AccountAdmin createAccountDtoToAccount(CreateAccountDto createAccountDto, @MappingTarget AccountAdmin accountAdmin);

}
