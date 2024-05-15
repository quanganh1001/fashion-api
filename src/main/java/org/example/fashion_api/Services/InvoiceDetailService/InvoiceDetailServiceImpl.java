package org.example.fashion_api.Services.InvoiceDetailService;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.InvoiceDetailMapper;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Repositories.InvoiceDetailRepo;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InvoiceDetailServiceImpl implements InvoiceDetailService{
    @Autowired
    private InvoiceDetailRepo invoiceDetailRepo;
    @Autowired
    private InvoiceDetailMapper invoiceDetailMapper ;
    @Autowired
    private InvoiceRepo invoiceRepo;
    @Autowired
    private ProductDetailRepo productDetailRepo;

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
    public InvoiceDetailRes createInvoiceDetail(Long invoiceId, Long productDetailId) {
        Invoice invoice = invoiceRepo.findById(invoiceId).orElseThrow(()
                ->new NotFoundException("Invoice not found"));

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
            invoiceDetail.setQuantity(1);

        }

        InvoiceDetail newInvoiceDetail = invoiceDetailRepo.save(invoiceDetail);

        return invoiceDetailMapper.invoiceDetailToInvoiceDetailRes(newInvoiceDetail);
    }

    @Override
    @Transactional
    public void changeQuantity(Long invoiceDetailId, int quantity) {
        InvoiceDetail invoiceDetail = invoiceDetailRepo.findById(invoiceDetailId).orElseThrow(()->new NotFoundException("Invoice"));

        invoiceDetail.setQuantity(quantity);

        invoiceDetailRepo.save(invoiceDetail);
    }

    @Override
    @Transactional
    public void deleteInvoiceDetail(Long invoiceDetailId) {
        InvoiceDetail invoiceDetail = invoiceDetailRepo.findById(invoiceDetailId).orElseThrow(()->new NotFoundException("Invoice detail"));
        invoiceDetailRepo.delete(invoiceDetail);
    }
}
