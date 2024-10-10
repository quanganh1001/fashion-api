package org.example.fashion_api.Models.Stored;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import org.example.fashion_api.Models.BaseEntity;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@Data
public class SalesStored {
    @Id
    private Long id;
    private Long totalSales;
    private Long totalInvoices;
}
