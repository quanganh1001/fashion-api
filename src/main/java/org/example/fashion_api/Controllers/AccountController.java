package org.example.fashion_api.Controllers;

import jakarta.validation.Valid;
import org.example.fashion_api.Models.Accounts.AccountRegisterDto;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Models.Accounts.AccountUpdateDto;
import org.example.fashion_api.Models.Accounts.ChangePassDto;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("accounts")
public class AccountController {
    @Autowired
    private AccountService accountService;



    @GetMapping()
    @PreAuthorize("hasAnyRole('MANAGER')")
    public ResponseEntity<?> getAllAccount(@RequestParam(defaultValue = "",required = false) String keyword,
                                          @RequestParam(defaultValue = "1") int page,
                                          @RequestParam(defaultValue = "10") int limit) {
        return accountService.getAllAccount(keyword,page-1,limit);
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
    public ResponseEntity<AccountRes> updateAccount(@PathVariable("accountId") Long accountId,@Valid @RequestBody AccountUpdateDto accountUpdateDto) {
        return accountService.updateAccount(accountId,accountUpdateDto);
    }

    @PutMapping("/{accountId}/changePage")
    public ResponseEntity<String> changePage(@PathVariable("accountId") Long accountId,@Valid @RequestBody ChangePassDto changePassDto) {
        accountService.changePass(accountId,changePassDto);
        return ResponseEntity.ok("Password changed successfully");
    }

    @PutMapping("/resetPass")
    public ResponseEntity<String> resetPass(String email) {
        accountService.resetPass(email);
        return ResponseEntity.ok("New password has been sent to registered email");
    }


}
