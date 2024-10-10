package org.example.fashion_api.Models.StoresAddress;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import org.example.fashion_api.Models.BaseEntity;
import org.example.fashion_api.Models.Invoices.Invoice;
import org.example.fashion_api.Models.InvoicesDetails.InvoiceDetail;

import java.util.ArrayList;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@Table(name = "stores")
@NoArgsConstructor(force = true)
@AllArgsConstructor
@Builder
public class StoresAddress extends BaseEntity {
    private String name;
    private String address;
    private String time;
    private String phone;
    private String api;
    private String city;

    @OneToMany(mappedBy = "orderSource", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    @ToString.Exclude
    private List<Invoice> invoices = new ArrayList<>();
}
