package org.example.fashion_api.Models.Stored;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.example.fashion_api.Models.BaseEntity;

import java.time.LocalDate;

@Entity
@Table(name = "sales_sent_view")
public class SalesSentStored extends BaseEntity {
    private Long total_sales;
    private Long total_invoices;
    private LocalDate confirmation_date;
}
