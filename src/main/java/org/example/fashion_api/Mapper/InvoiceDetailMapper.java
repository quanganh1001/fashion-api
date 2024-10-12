package org.example.fashion_api.Mapper;

import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.Invoices.InvoiceRes;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailDto;
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

@Mapper(componentModel = "spring",uses = {ProductDetailMapper.class}, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface InvoiceDetailMapper {

    List<InvoiceDetailRes> toResList(List<InvoiceDetail> invoiceDetails);

    @Mapping(target = "invoiceId", source = "invoice.id")
    @Mapping(target = "productName", source = "productDetail.product.productName")
    @Mapping(target = "color", source = "productDetail.color.name")
    @Mapping(target = "code", source = "productDetail.code")
    @Mapping(target = "size", source = "productDetail.size")
    @Mapping(target = "imgUrl", source = "productDetail.imageBackground")
    InvoiceDetailRes invoiceDetailToInvoiceDetailRes(InvoiceDetail invoiceDetails);


}
