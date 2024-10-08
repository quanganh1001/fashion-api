package org.example.fashion_api.Mapper;

import org.example.fashion_api.Enum.InvoiceStatusEnum;
import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Invoices.*;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring",uses = {InvoiceDetailMapper.class}, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface InvoiceMapper {

    @Mapping(target = "invoice.invoicesDetails", ignore = true)
    List<InvoiceRes> toResList(List<Invoice> invoices);

    @Mapping(target = "accountId", source = "account.id")
    @Mapping(target = "accountName", source = "account.name")
    @Mapping(target = "invoicesDetails", source = "invoicesDetails")
    @Mapping(target = "store", source = "orderSource.name",defaultValue = "online")
    InvoiceRes invoiceToInvoiceRes(Invoice invoice);

    @Mapping(target = "invoicesDetails", ignore = true)
    Invoice checkoutDtoToInvoice(CheckoutDto checkoutDto, @MappingTarget Invoice invoice);

    @Mapping(target = "orderSource.id", source = "store")
    Invoice createInvoiceDtoToInvoice(CreateInvoiceDto checkoutDto, @MappingTarget Invoice invoice);

    @Mapping(target = "isPaid", source = "isPaid")
    @Mapping(target = "account.id", source = "accountId")
    Invoice updateInvoiceToInvoice(UpdateInvoiceDto updateInvoiceDto, @MappingTarget Invoice invoice);

}
