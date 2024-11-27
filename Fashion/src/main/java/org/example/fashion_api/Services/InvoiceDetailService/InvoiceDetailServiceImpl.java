package org.example.fashion_api.Services.InvoiceDetailService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.InvoiceDetailMapper;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Repositories.InvoiceDetailRepo;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Services.InvoiceHistoryService.InvoiceHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class InvoiceDetailServiceImpl implements InvoiceDetailService{

    private final InvoiceDetailRepo invoiceDetailRepo;
    private final InvoiceDetailMapper invoiceDetailMapper ;
    private final InvoiceRepo invoiceRepo;
    private final ProductDetailRepo productDetailRepo;
    private final InvoiceHistoryService invoiceHistoryService;

    @Override
    public List<InvoiceDetailRes> getAllInvoicesDetailsByInvoice(Long invoiceId){
        return invoiceDetailMapper.toResList(invoiceDetailRepo.findAllByInvoiceId(invoiceId));
    }

    @Override
    public InvoiceDetailRes getById(Long invoiceDetailId) {
        return invoiceDetailMapper.invoiceDetailToInvoiceDetailRes(invoiceDetailRepo.findById(invoiceDetailId)
                .orElseThrow(()->new NotFoundException("Invoice detail not found")));
    }

    @Override
    public InvoiceDetailRes createInvoiceDetail(Long invoiceId, Long productDetailId, int quantity) {
        Invoice invoice = invoiceRepo.findById(invoiceId).orElseThrow(()
                ->new NotFoundException("Invoice not found"));

        if( ((invoice.getInvoiceStatus() != InvoiceStatusEnum.NEW &&
                invoice.getInvoiceStatus() != InvoiceStatusEnum.CANCEL &&
                invoice.getInvoiceStatus() != InvoiceStatusEnum.PROCESS) ||
                invoice.getIsPaid()) && invoice.getOrderSource() == null){
            throw new BadRequestException("Order created or paid cannot add products");
        }


        ProductDetail productDetail = productDetailRepo.findById(productDetailId).orElseThrow(()
                ->new NotFoundException("Product detail not found"));



        InvoiceDetail invoiceDetail = invoiceDetailRepo.findByInvoiceIdAndProductDetailId(invoiceId,productDetailId);


        if (invoiceDetail != null){
            // quantity +1
            invoiceDetail.setQuantity(invoiceDetail.getQuantity()+1);

        }else {
            // create invoice detail
            Long price = productDetail.getProduct().getDiscountPrice() == null
                    ? productDetail.getProduct().getPrice()
                    : productDetail.getProduct().getDiscountPrice();

            invoiceDetail = new InvoiceDetail();
            invoiceDetail.setInvoice(invoice);
            invoiceDetail.setProductDetail(productDetail);
            invoiceDetail.setPrice(price);
            invoiceDetail.setQuantity(quantity);

        }

        invoiceHistoryService.setNameVarForTrigger();

        InvoiceDetail newInvoiceDetail = invoiceDetailRepo.save(invoiceDetail);

        return invoiceDetailMapper.invoiceDetailToInvoiceDetailRes(newInvoiceDetail);
    }

    @Override
    @Transactional
    public void changeQuantity(Long invoiceDetailId, int quantity) {
        InvoiceDetail invoiceDetail = invoiceDetailRepo.findById(invoiceDetailId).orElseThrow(()->new NotFoundException("Invoice"));
        invoiceHistoryService.setNameVarForTrigger();
        if (quantity == 0){
            invoiceDetailRepo.delete(invoiceDetail);
        }else {
            invoiceDetail.setQuantity(quantity);
            invoiceDetailRepo.save(invoiceDetail);
        }
    }

    @Override
    @Transactional
    public void deleteInvoiceDetail(Long invoiceDetailId) {
        InvoiceDetail invoiceDetail = invoiceDetailRepo.findById(invoiceDetailId).orElseThrow(()->new NotFoundException("Invoice detail"));
        invoiceHistoryService.setNameVarForTrigger();
        invoiceDetailRepo.delete(invoiceDetail);
    }
}
