package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.StoresAddress.StoresAddress;
import org.example.fashion_api.Services.StoreAddressService.StoreAddressService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("stores")
@RequiredArgsConstructor
public class StoreAddressController {
    private final StoreAddressService storeAddressService;

    @Operation(summary = "get stores")
    @GetMapping()
    public ResponseEntity<List<StoresAddress>> getAllStoreAddresses() {
        return ResponseEntity.ok(storeAddressService.getAll());
    }
}
