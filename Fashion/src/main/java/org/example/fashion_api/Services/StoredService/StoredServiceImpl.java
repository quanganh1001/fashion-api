package org.example.fashion_api.Services.StoredService;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Stored.SalesStored;
import org.example.fashion_api.Models.Stored.TopProductStored;
import org.example.fashion_api.Repositories.SalesStoredRepo;
import org.example.fashion_api.Repositories.TopProductStoredRepo;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StoredServiceImpl implements StoredService {
    private final TopProductStoredRepo topProductStoredRepo;
    private final SalesStoredRepo salesStoredRepo;


    @Override
    public List<TopProductStored> findTopProduct(LocalDate startDate, LocalDate endDate,Long store) throws JsonProcessingException {
        if (store == 0){
            return topProductStoredRepo.findAllTopProduct(startDate,endDate);
        }else if (store == -1) {
            return topProductStoredRepo.findTopProductByStore(startDate,endDate,null);
        }else {
            return topProductStoredRepo.findTopProductByStore(startDate,endDate,store);
        }

    }

    @Override
    public SalesStored findSalesSent(LocalDate startDate, LocalDate endDate) throws JsonProcessingException {
        return salesStoredRepo.findSaleSentStored(startDate,endDate);
    }

    @Override
    public SalesStored findSalesSuccess(LocalDate startDate, LocalDate endDate,Long store) throws JsonProcessingException {
        if (store == 0){
            return salesStoredRepo.findAllSaleSuccess(startDate,endDate);
        }else if (store == -1) {
            return salesStoredRepo.findSaleSuccessAtStore(startDate,endDate,null);
        }else {
            return salesStoredRepo.findSaleSuccessAtStore(startDate,endDate,store);
        }

    }



}
