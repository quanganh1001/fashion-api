package org.example.fashion_api.Services.InvoiceService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.InvoiceMapper;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.Invoices.*;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Repositories.AccountRepo;
import org.example.fashion_api.Repositories.InvoiceDetailRepo;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.example.fashion_api.Services.InvoiceDetailService.InvoiceDetailService;
import org.example.fashion_api.Services.InvoiceHistoryService.InvoiceHistoryService;
import org.example.fashion_api.Services.VnpayService;
import org.springframework.data.domain.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class InvoiceServiceImpl implements InvoiceService {

    private final InvoiceRepo invoiceRepo;
    private final InvoiceMapper invoiceMapper;
    private final InvoiceDetailService invoiceDetailService;
    private final InvoiceDetailRepo invoiceDetailRepo;
    private final VnpayService vnpayService;
    private final ProductDetailRepo productDetailRepo;
    private final AccountService accountService;
    private final AccountRepo accountRepo;
    private final InvoiceHistoryService invoiceHistoryService;


    @Override
    public PageInvoiceRes getAllInvoices(String keyword, int page, int pageSize, Long accountId, InvoiceStatusEnum invoiceStatus) {
        if (page < 0) {
            page = 0;
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();


        PageRequest pageRequest = PageRequest.of(page, pageSize, Sort.by("created_at").descending());

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
                .totalItems(totalInvoices)
                .invoices(invoicesRes)
                .build();
    }

    @Override
    @Transactional
    public InvoiceRes createInvoice(CheckoutDto checkoutDto) {
        Invoice invoice = invoiceMapper.checkoutDtoToInvoice(checkoutDto, new Invoice());

        invoiceHistoryService.setNameVarForTrigger();
        Invoice newInvoice = invoiceRepo.save(invoice);

        return invoiceMapper.invoiceToInvoiceRes(newInvoice);
    }

    @Override
    @Transactional
    public String checkoutByCash(CheckoutDto checkoutDto){
        InvoiceRes invoiceRes = createInvoice(checkoutDto);

        for (InvoiceDetailDto invoiceDetail : checkoutDto.getInvoicesDetails()) {
            invoiceDetailService.createInvoiceDetail(invoiceRes.getId(), invoiceDetail.getProductDetailId());
        }

        return "http://localhost:3000/response?success=1";

    }

    @Override
    public InvoiceRes getById(Long invoiceId) {
        return invoiceMapper.invoiceToInvoiceRes(invoiceRepo.findById(invoiceId)
                .orElseThrow(() -> new NotFoundException("Invoice")));
    }

    @Override
    @Transactional
    public void updateShippingFee(Long invoiceId, Long shippingFee) {
        Invoice invoice = invoiceRepo.findById(invoiceId).orElseThrow(() -> new NotFoundException("Invoice"));

        invoice.setShippingFee(shippingFee);

        invoice.setTotalBill(invoice.getTotalPrice() + shippingFee);

        invoiceHistoryService.setNameVarForTrigger();

        invoiceRepo.save(invoice);


    }

    @Override
    @Transactional
    public void deleteInvoice(Long invoiceId) {
        Invoice invoice = invoiceRepo.findById(invoiceId).orElseThrow(() -> new NotFoundException("Invoice"));
        invoiceRepo.delete(invoice);
    }

    @Override
    @Transactional
    public String checkout(HttpServletRequest http, CheckoutDto checkoutDto) {

        InvoiceRes invoiceRes = createInvoice(checkoutDto);

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

        if (currentInvoice.getAccount() == null){
            throw new BadRequestException("Please divide the order to the staff first.");
        }
        checkValidStatus(currentInvoice,status);

        updateDateTime(currentInvoice, status.getValue());

        updateQuantityProduct(status.getValue(),currentInvoice);


        invoiceHistoryService.setNameVarForTrigger();

        invoiceRepo.changeStatusInvoice(invoiceId, status.name());

    }

    private void checkValidStatus(Invoice currentInvoice, InvoiceStatusEnum status) {
        // CANCEL or NEW cannot update to DELIVERING,SUCCESS,RETURN
        if ((currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.CANCEL
                || currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.NEW)
                && status.getValue() >= 4) {
            throw new BadRequestException("Status " + currentInvoice.getInvoiceStatus() + " cannot update to " + status);
        }

        // ORDER_CREATED cannot update to SUCCESS,RETURN
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.ORDER_CREATED
                && status.getValue() >= 5) {
            throw new BadRequestException("Status " + currentInvoice.getInvoiceStatus() + " cannot update to " + status);
        }

        // DELIVERING cannot update to CANCEL,ORDER_CREATED,NEW
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.DELIVERING
                && status.getValue() <= 3) {
            throw new BadRequestException("Status " + currentInvoice.getInvoiceStatus() + " cannot update to " + status);
        }

        // SUCCESS cannot update status
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.SUCCESS
                && status.getValue() != 6) {
            throw new BadRequestException("Status " + currentInvoice.getInvoiceStatus() + " cannot update to " + status);
        }

        // PROCESS cannot update status
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.PROCESS
                && status.getValue() >= 4) {
            throw new BadRequestException("Status " + currentInvoice.getInvoiceStatus() + " cannot update to " + status);
        }

        // RETURN cannot update status
        if (currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.RETURN
                && status.getValue() != 6) {
            throw new BadRequestException("Status " + currentInvoice.getInvoiceStatus() + " cannot update to " + status);
        }


    }

    @Override
    public InvoiceRes updateInvoice(Long invoiceId, UpdateInvoiceDto dto) {
        Invoice currentInvoice = invoiceRepo.findById(invoiceId).orElseThrow(() -> new NotFoundException("Invoice"));
        var newAccountId = dto.getAccountId();
        var currentAccount = currentInvoice.getAccount();
        checkValidStatus(currentInvoice,dto.getInvoiceStatus());

        if ((currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.SUCCESS
                || currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.DELIVERING
                || currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.RETURN
                || currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.ORDER_CREATED)
        && (!Objects.equals(currentInvoice.getName(), dto.getName()) || !Objects.equals(currentInvoice.getPhone(),
                dto.getPhone()) || !Objects.equals(currentInvoice.getAddress(), dto.getAddress()) )) {
            throw new BadRequestException("Status " + currentInvoice.getInvoiceStatus() + " cannot update invoice");
        }

        if (newAccountId != null && (currentAccount == null || !newAccountId.equals(currentAccount.getId()))) {
            Account newAccount = accountRepo.findById(dto.getAccountId())
                    .orElseThrow(() -> new NotFoundException("Account"));
            currentInvoice.setAccount(newAccount);
        }

        if(newAccountId == null){
            throw new BadRequestException("Please divide the order to the staff first.");
        }

        updateDateTime(currentInvoice, dto.getInvoiceStatus().getValue());

        updateQuantityProduct(dto.getInvoiceStatus().getValue(),currentInvoice);


        invoiceHistoryService.setNameVarForTrigger();

        Invoice invoice = invoiceRepo.save(invoiceMapper.updateInvoiceToInvoice(dto, currentInvoice));
        return invoiceMapper.invoiceToInvoiceRes(invoice);
    }

    private void updateDateTime(Invoice currentInvoice, int value) {
        if(currentInvoice.getInvoiceStatus().getValue() != value && value == 3){
            currentInvoice.setConfirmationDate(LocalDate.now().atStartOfDay());
        }

        if(currentInvoice.getInvoiceStatus().getValue() == 3 && value < 3){
            currentInvoice.setConfirmationDate(null);
        }

        if(currentInvoice.getInvoiceStatus().getValue() != value && value == 5){
            currentInvoice.setSuccessfulDate(LocalDate.now().atStartOfDay());
        }
    }

    public void updateQuantityProduct(int newStatus,Invoice currentInvoice){
        if ((newStatus != currentInvoice.getInvoiceStatus().getValue()) && newStatus == 3){
            List<InvoiceDetail> invoiceDetails = invoiceDetailRepo.findAllByInvoiceId(currentInvoice.getId());

            for (InvoiceDetail invoiceDetail : invoiceDetails) {
                int currentQuantity = invoiceDetail.getProductDetail().getQuantity();
                invoiceDetail.getProductDetail().setQuantity(currentQuantity - invoiceDetail.getQuantity());
            }
        }

        if(currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.ORDER_CREATED && (newStatus == 0 || newStatus == 1 || newStatus == 2))
        {
            List<InvoiceDetail> invoiceDetails = invoiceDetailRepo.findAllByInvoiceId(currentInvoice.getId());

            for (InvoiceDetail invoiceDetail : invoiceDetails) {
                int currentQuantity = invoiceDetail.getProductDetail().getQuantity();
                invoiceDetail.getProductDetail().setQuantity(currentQuantity + invoiceDetail.getQuantity());
            }
        }

        if(currentInvoice.getInvoiceStatus() == InvoiceStatusEnum.DELIVERING && (newStatus == 6))
        {
            List<InvoiceDetail> invoiceDetails = invoiceDetailRepo.findAllByInvoiceId(currentInvoice.getId());

            for (InvoiceDetail invoiceDetail : invoiceDetails) {
                int currentQuantity = invoiceDetail.getProductDetail().getQuantity();
                invoiceDetail.getProductDetail().setQuantity(currentQuantity + invoiceDetail.getQuantity());
            }
        }
    };

}
