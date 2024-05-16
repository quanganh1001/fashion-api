package org.example.fashion_api.Controllers;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Enum.RoleEnum;
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


    @PreAuthorize("hasAnyRole('MANAGER')")
    @GetMapping()
    public ResponseEntity<?> getAllAccount(@RequestParam(defaultValue = "",required = false) String keyword,
                                          @RequestParam(defaultValue = "1") int page,
                                          @RequestParam(defaultValue = "10") int limit) {
        return accountService.getAllAccount(keyword,page-1,limit);
    }

    @PreAuthorize("#accountId == authentication.principal.account.Id or hasAnyRole('MANAGER')")
    @GetMapping("/{accountId}")
    public AccountRes getAccount(@PathVariable("accountId") Long accountId) {
        return accountService.getAccount(accountId);
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @DeleteMapping("/{accountId}")
    public ResponseEntity<String> deleteAccount(@PathVariable("accountId") Long accountId) {
            accountService.deleteAccount(accountId);
            return ResponseEntity.ok("Deleted");
    }

    @PreAuthorize("#accountId == authentication.principal.account.Id or hasAnyRole('MANAGER')")
    @PutMapping("/{accountId}")
    public ResponseEntity<AccountRes> updateAccount(@PathVariable("accountId") Long accountId,@Valid @RequestBody AccountUpdateDto accountUpdateDto) {
        return accountService.updateAccount(accountId,accountUpdateDto);
    }


    @PutMapping("/{accountId}/changePass")
    public ResponseEntity<String> changePass(@PathVariable("accountId") Long accountId,@Valid @RequestBody ChangePassDto changePassDto) {
        accountService.changePass(accountId,changePassDto);
        return ResponseEntity.ok("Password changed successfully");
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @PutMapping("/{accountId}/updateRole")
    public ResponseEntity<String> updateRole(@PathVariable("accountId") Long accountId,@RequestBody RoleEnum role) {
        accountService.updateRole(accountId,role);
        return ResponseEntity.ok("Successfully");
    }

}
