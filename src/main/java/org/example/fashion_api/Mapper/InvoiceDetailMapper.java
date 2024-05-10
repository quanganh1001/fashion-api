package org.example.fashion_api.Mapper;

import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.Invoices.InvoiceRes;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface InvoiceDetailMapper {


    List<InvoiceDetailRes> toResList(List<InvoiceDetail> invoiceDetails);

    @Mapping(target = "invoice", source = "invoice")
    InvoiceDetailRes invoiceDetailToInvoiceDetailRes(InvoiceDetail invoiceDetails);


    @Mapping(target = "invoicesDetails", ignore = true)
    InvoiceRes invoiceToInvoiceRes(Invoice invoice);

}
