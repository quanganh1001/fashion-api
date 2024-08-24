package org.example.fashion_api.Mapper;

import org.example.fashion_api.Models.StoresAddress.StoresAddress;
import org.example.fashion_api.Models.StoresAddress.StoresAddressRes;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface StoresAddressMapper {
    List<StoresAddressRes> toListStoresAddress(List<StoresAddress> storesAddresses);

    StoresAddressRes storesAddressToStoresAddressRes(StoresAddress storesAddress);
}
