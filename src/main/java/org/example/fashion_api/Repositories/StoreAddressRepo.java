package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.StoresAddress.StoresAddress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StoreAddressRepo extends JpaRepository<StoresAddress,Long> {
}
