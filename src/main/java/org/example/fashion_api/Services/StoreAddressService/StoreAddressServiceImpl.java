package org.example.fashion_api.Services.StoreAddressService;

import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.StoresAddress.StoresAddress;
import org.example.fashion_api.Repositories.StoreAddressRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class StoreAddressServiceImpl implements StoreAddressService {
    private final StoreAddressRepo storeAddressRepo;

    @Override
    public List<StoresAddress> getAll() {
        return storeAddressRepo.findAll();
    }
}
