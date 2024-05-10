package org.example.fashion_api.Mapper;

import org.example.fashion_api.Models.Colors.Color;
import org.example.fashion_api.Models.Colors.ColorDto;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.Invoices.InvoiceRes;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetailRes;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Models.ProductsDetails.ProductDetailRes;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface InvoiceMapper {
    List<InvoiceRes> toResList(List<Invoice> invoices);

    @Mapping(target = "invoicesDetails", source = "invoicesDetails")
    InvoiceRes invoiceToInvoiceRes(Invoice invoice);

    @Mapping(target = "invoice",ignore = true)
    InvoiceDetailRes invoiceDetailToInvoiceDetailRes(InvoiceDetail invoiceDetail);

    @Mapping(target = "product", source = "product")
    ProductDetailRes productDetailToProductDetailRes(ProductDetail productDetail);

    @Mapping(target = "catId",source = "category.catId")
    @Mapping(target = "productsDetails", ignore = true)
    ProductRes productToProductRes(Product product);
}
