package org.example.fashion_api.Services.InvoiceDetailService;

import org.example.fashion_api.Mapper.InvoiceDetailMapper;
import org.example.fashion_api.Mapper.InvoiceDetailMapperImpl;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Repositories.InvoiceDetailRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InvoiceDetailServiceImpl implements InvoiceDetailService{
    @Autowired
    private InvoiceDetailRepo invoiceDetailRepo;
    @Autowired
    private InvoiceDetailMapper invoiceDetailMapper ;

    @Override
    public List<InvoiceDetailRes> getAllInvoicesDetailsByInvoice(String invoiceId){
        return invoiceDetailMapper.toResList(invoiceDetailRepo.findAllByInvoiceInvoiceId(invoiceId));
    }
}
