package org.example.fashion_api.Services.InvoiceService;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.InvoiceMapper;
import org.example.fashion_api.Models.Invoices.CreateInvoiceDto;
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

        return PageInvoiceRes.builder()
                                            .currentPage(page+1)
                                            .totalPages(pageInvoices.getTotalPages())
                                            .totalInvoices(totalInvoices)
                                            .invoices(invoicesRes)
                                            .build();
    }

    @Override
    public InvoiceRes createInvoice(CreateInvoiceDto createInvoiceDto){
        Invoice invoice = invoiceMapper.createInvoiceToInvoice(createInvoiceDto,new Invoice());

        Invoice newInvoice = invoiceRepo.save(invoice);

        return invoiceMapper.invoiceToInvoiceRes(newInvoice);
    }

    @Override
    public InvoiceRes getById(String invoiceId) {
        return invoiceMapper.invoiceToInvoiceRes(invoiceRepo.findById(invoiceId)
                .orElseThrow(()->new NotFoundException("Invoice not found")));
    }

    @Override
    public void updateShippingFee(String invoiceId, Long shippingFee) {
        Invoice invoice = invoiceRepo.findById(invoiceId).orElseThrow(()->new NotFoundException("Invoice not found"));

        invoice.setShippingFee(shippingFee);

        invoice.setTotalBill(invoice.getTotalPrice() + shippingFee);

        invoiceRepo.save(invoice);

    }

}
