package org.example.fashion_api.Services.InvoiceService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.InvoiceMapper;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.Invoices.*;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Repositories.AccountRepo;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.example.fashion_api.Services.AccountService.AccountServiceImpl;
import org.example.fashion_api.Services.InvoiceDetailService.InvoiceDetailService;
import org.example.fashion_api.Services.VnpayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InvoiceServiceImpl implements InvoiceService {
    @Autowired
    private InvoiceRepo invoiceRepo;
    @Autowired
    private InvoiceMapper invoiceMapper;
    @Autowired
    private InvoiceDetailService invoiceDetailService;
    @Autowired
    private VnpayService vnpayService;
    @Autowired
    private ProductDetailRepo productDetailRepo;
    @Autowired
    private AccountService accountService;
    @Autowired
    private AccountRepo accountRepo;

    @Override
    public PageInvoiceRes getAllInvoices(String keyword, int page, int pageSize, Long accountId, InvoiceStatusEnum invoiceStatus) {
        if (page < 0) {
            page = 0;
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();


        PageRequest pageRequest = PageRequest.of(page, pageSize, Sort.by("created_at").ascending());

        Page<Invoice> pageInvoices;

        boolean isManager = authentication.getAuthorities().stream()
                .anyMatch(authority -> authority.getAuthority().equals("ROLE_MANAGER"));

        if (!isManager) {
            Account account = accountService.getAccountFromAuthentication();
            accountId = account.getId();
        }


        if (accountId != null && accountId == 0) {
            if (invoiceStatus != null) {
                pageInvoices = invoiceRepo.searchInvoicesWithStatus(keyword, invoiceStatus.name(), pageRequest);
            } else {
                pageInvoices = invoiceRepo.searchInvoices(keyword, pageRequest);
            }

        } else {
            if (invoiceStatus != null) {
                pageInvoices = invoiceRepo.searchInvoicesByAccountWithStatus(accountId, keyword, invoiceStatus.name(), pageRequest);
            } else {
                pageInvoices = invoiceRepo.searchInvoicesByAccount(accountId, keyword, pageRequest);
            }
        }


        List<InvoiceRes> invoicesRes = invoiceMapper.toResList(pageInvoices.getContent());

        long totalInvoices = pageInvoices.getTotalElements();

        return PageInvoiceRes.builder()
                .currentPage(page + 1)
                .totalPages(pageInvoices.getTotalPages())
                .totalInvoices(totalInvoices)
                .invoices(invoicesRes)
                .build();
    }

    @Override
    public InvoiceRes createInvoice(CreateInvoiceDto createInvoiceDto) {
        Invoice invoice = invoiceMapper.createInvoiceToInvoice(createInvoiceDto, new Invoice());

        Invoice newInvoice = invoiceRepo.save(invoice);

        return invoiceMapper.invoiceToInvoiceRes(newInvoice);
    }

    @Override
    public InvoiceRes getById(Long invoiceId) {
        return invoiceMapper.invoiceToInvoiceRes(invoiceRepo.findById(invoiceId)
                .orElseThrow(() -> new NotFoundException("Invoice")));
    }

    @Override
    public void updateShippingFee(Long invoiceId, Long shippingFee) {
        Invoice invoice = invoiceRepo.findById(invoiceId).orElseThrow(() -> new NotFoundException("Invoice"));

        invoice.setShippingFee(shippingFee);

        invoice.setTotalBill(invoice.getTotalPrice() + shippingFee);

        invoiceRepo.save(invoice);

    }

    @Override
    @Transactional
    public void deleteInvoice(Long invoiceId) {
        Invoice invoice = invoiceRepo.findById(invoiceId).orElseThrow(() -> new NotFoundException("Invoice"));
        invoiceRepo.delete(invoice);
    }

    @Override
    public String checkout(HttpServletRequest http, CheckoutDto checkoutDto) {
        CreateInvoiceDto createInvoiceDto = CreateInvoiceDto.builder()
                .accountId(checkoutDto.getAccountId())
                .address(checkoutDto.getAddress())
                .phone(checkoutDto.getPhone())
                .name(checkoutDto.getName())
                .customerNote(checkoutDto.getCustomerNote())
                .shippingFee(checkoutDto.getShippingFee())
                .build();
        InvoiceRes invoiceRes = createInvoice(createInvoiceDto);

        long totalPrice = 0;

        for (InvoiceDetailDto invoiceDetail : checkoutDto.getInvoicesDetails()) {
            ProductDetail productDetail = productDetailRepo.findById(invoiceDetail.getProductDetailId()).orElseThrow(() -> new NotFoundException("Product"));

            totalPrice += (productDetail.getProduct().getPrice() * invoiceDetail.getQuantity());

            invoiceDetailService.createInvoiceDetail(invoiceRes.getId(), invoiceDetail.getProductDetailId());
        }


        return vnpayService.createPaymentUrl(http, invoiceRes.getId(), totalPrice + checkoutDto.getShippingFee());

    }


    @Override
    @Transactional
    public void updateStatus(Long invoiceId, InvoiceStatusEnum status) {
        Invoice currentInvoice = invoiceRepo.findById(invoiceId).orElseThrow(() -> new NotFoundException("Invoice"));

        // CANCEL or NEW cannot update to DELIVERING,SUCCESS,RETURN
        if ((currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.CANCEL
                || currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.NEW)
                && status.getValue() >= 4) {
            throw new BadRequestException("Status" + currentInvoice.getInvoiceStatus() + " cannot update to" + status);
        }

        // ORDER_CREATED cannot update to SUCCESS,RETURN
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.ORDER_CREATED
                && status.getValue() >= 5) {
            throw new BadRequestException("Status" + currentInvoice.getInvoiceStatus() + " cannot update to" + status);
        }

        // DELIVERING cannot update to CANCEL,ORDER_CREATED,NEW
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.DELIVERING
                && status.getValue() <= 3) {
            throw new BadRequestException("Status" + currentInvoice.getInvoiceStatus() + " cannot update to" + status);
        }

        // SUCCESS cannot update status
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.SUCCESS
                && status.getValue() != 6) {
            throw new BadRequestException("Status" + currentInvoice.getInvoiceStatus() + " cannot update to" + status);
        }

        // RETURN cannot update status
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.RETURN
                && status.getValue() != 6) {
            throw new BadRequestException("Status" + currentInvoice.getInvoiceStatus() + " cannot update to" + status);
        }

        invoiceRepo.changeStatusInvoice(invoiceId, status.getValue());

    }

    @Override
    public InvoiceRes updateInvoice(Long invoiceId, UpdateInvoiceDto dto) {
        Invoice currentInvoice = invoiceRepo.findById(invoiceId).orElseThrow(() -> new NotFoundException("Invoice"));

        if ((currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.SUCCESS)
                || currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.DELIVERING
                || currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.RETURN
                || currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.ORDER_CREATED) {
            throw new BadRequestException("Status " + currentInvoice.getInvoiceStatus() + " cannot update invoice");
        }


        if (dto.getAccountId() != null && !dto.getAccountId().equals(currentInvoice.getAccount().getId())) {
            Account newAccount = accountRepo.findById(dto.getAccountId())
                    .orElseThrow(() -> new NotFoundException("Account"));
            currentInvoice.setAccount(newAccount);
        }

        Invoice invoice = invoiceRepo.save(invoiceMapper.updateInvoiceToInvoice(dto, currentInvoice));
        return invoiceMapper.invoiceToInvoiceRes(invoice);
    }
}
