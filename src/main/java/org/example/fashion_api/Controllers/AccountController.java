package org.example.fashion_api.Controllers;

import jakarta.validation.Valid;
import org.example.fashion_api.Models.Account.AccountRegisterDto;
import org.example.fashion_api.Models.Account.AccountRes;
import org.example.fashion_api.Models.Account.AccountUpdateDto;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("accounts")
public class AccountController {
    @Autowired
    private AccountService accountService;



    @GetMapping()
    @PreAuthorize("hasAnyRole('MANAGER')")
    public List<AccountRes> getAllAccount() {
        return accountService.getAllAccount();
    }

    @GetMapping("/{accountId}")
    @PreAuthorize("#accountId == authentication.principal.account.accountId or hasAnyRole('MANAGER')")
    public AccountRes getAccount(@PathVariable("accountId") Long accountId) {
        return accountService.getAccount(accountId);
    }

    @PostMapping("/register")
    public AccountRes registerAccount(@Valid @RequestBody AccountRegisterDto accountRegisterDto) {
        return accountService.registerAccount(accountRegisterDto);
    }

    @DeleteMapping("/{accountId}")
    @PreAuthorize("hasAnyRole('MANAGER')")
    public ResponseEntity<String> deleteAccount(@PathVariable("accountId") Long accountId) {
            accountService.deleteAccount(accountId);
            return ResponseEntity.ok("Deleted");
    }

    @PutMapping("/{accountId}")
    @PreAuthorize("#accountId == authentication.principal.account.accountId or hasAnyRole('MANAGER')")
    public AccountRes updateAccount(@PathVariable("accountId") Long accountId,@Valid @RequestBody AccountUpdateDto accountUpdateDto) {
        return accountService.updateAccount(accountId,accountUpdateDto);
    }
}
