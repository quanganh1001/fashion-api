package org.example.fashion_api.Services.InvoiceService;

import org.example.fashion_api.Mapper.InvoiceMapper;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.Invoices.InvoiceRes;
import org.example.fashion_api.Models.Invoices.PageInvoiceRes;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InvoiceServiceImpl implements InvoiceService {
    @Autowired
    private InvoiceRepo invoiceRepo;
    @Autowired
    private InvoiceMapper invoiceMapper;

    @Override
    public PageInvoiceRes getAllInvoices(String keyword, int page, int pageSize) {
        if(page < 0){
            page = 0;
        }

        PageRequest pageRequest = PageRequest.of(page,pageSize, Sort.by("createdAt").ascending());

        Page<Invoice> pageInvoices = invoiceRepo.findAllByPhoneContainingIgnoreCaseOrInvoiceIdContainingIgnoreCase(keyword,keyword,pageRequest);

        List<InvoiceRes> invoicesRes = invoiceMapper.toResList(pageInvoices.getContent());

        var totalInvoices = invoiceRepo.count();

        var pageInvoiceRes = PageInvoiceRes.builder()
                                            .currentPage(page+1)
                                            .totalPages(pageInvoices.getTotalPages())
                                            .totalInvoices(totalInvoices)
                                            .invoices(invoicesRes)
                                            .build();

        return pageInvoiceRes;
    }
}
