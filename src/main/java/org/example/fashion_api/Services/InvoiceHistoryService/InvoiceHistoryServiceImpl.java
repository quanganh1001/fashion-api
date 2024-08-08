package org.example.fashion_api.Services.InvoiceHistoryService;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Models.Accounts.Account;
import org.example.fashion_api.Models.InvoicesHistory.InvoiceHistory;
import org.example.fashion_api.Models.InvoicesHistory.InvoiceHistoryRes;
import org.example.fashion_api.Repositories.InvoiceHistoryRepo;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class InvoiceHistoryServiceImpl implements InvoiceHistoryService {
    @PersistenceContext
    private EntityManager entityManager;

    private final AccountService accountService;
    private final InvoiceHistoryRepo invoiceHistoryRepo;

    @Override
    public List<InvoiceHistoryRes> getInvoiceHistory(Long invoiceId) {
        List<InvoiceHistory> invoiceHistories = invoiceHistoryRepo.findByInvoiceId(invoiceId);

        invoiceHistories.sort((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()));

        List<InvoiceHistoryRes> invoiceHistoryResList = new LinkedList<>();

        for (InvoiceHistory invoiceHistory : invoiceHistories) {
            invoiceHistoryResList.add(
                    InvoiceHistoryRes.builder()
                            .content(invoiceHistory.getContent())
                            .createAt(formatCreateAt(invoiceHistory.getCreatedAt()))
                            .build());
        }

        return invoiceHistoryResList;
    }

    private String formatCreateAt(LocalDateTime createAt) {
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(createAt, now);

        if (duration.toMinutes() < 1) {
            return "Vừa xong";
        } else if (duration.toHours() < 1) {
            return duration.toMinutes() + " phút trước";
        } else if (duration.toDays() < 1) {
            return duration.toHours() + " giờ trước";
        } else if (duration.toDays() <= 15) {
            return duration.toDays() + " ngày trước";
        } else {
            return createAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        }
    }

    @Override
    @Transactional
    public void setNameVarForTrigger() {
        try {
            Account account = accountService.getAccountFromAuthentication();
            String currentUsername = account.getName();
            if (!Objects.equals(currentUsername, "anonymousUser")) {
                entityManager.createNativeQuery("SET @current_user = :currentUsername")
                        .setParameter("currentUsername", currentUsername)
                        .executeUpdate();
            } else {
                entityManager.createNativeQuery("SET @current_user = :currentUsername")
                        .setParameter("currentUsername", "Khách hàng")
                        .executeUpdate();
            }
        }catch (Exception e) {
            entityManager.createNativeQuery("SET @current_user = :currentUsername")
                    .setParameter("currentUsername", "Khách hàng")
                    .executeUpdate();
        }
    }
}
