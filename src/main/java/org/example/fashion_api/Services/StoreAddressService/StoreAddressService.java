package org.example.fashion_api.Services.StoreAddressService;

import org.example.fashion_api.Models.StoresAddress.StoresAddress;
import org.springframework.stereotype.Service;

import java.util.List;

public interface StoreAddressService {
    List<StoresAddress> getAll();
}
