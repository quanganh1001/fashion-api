package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Enum.RoleEnum;
import org.example.fashion_api.Models.Accounts.*;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("accounts")
public class AccountController {
    private final AccountService accountService;

    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "get all accounts (role MANAGER)")
    @GetMapping()
    public ResponseEntity<?> getAllAccount(@RequestParam(defaultValue = "",required = false) String keyword,
                                          @RequestParam(defaultValue = "1") int page,
                                          @RequestParam(defaultValue = "10") int limit,
                                          @RequestParam(defaultValue = "") String role) {

        return accountService.getAllAccount(keyword,page-1,limit,role);
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "get all accounts employee (role MANAGER)")
    @GetMapping("getAllEmployees")
    public ResponseEntity<List<AccountRes>> getAllAccountEmployees() {
        return ResponseEntity.ok(accountService.getAllAccountEmployees());
    }


    @GetMapping("/current")
    @Operation(summary = "get current account")
    public ResponseEntity<AccountRes> getCurrentAccount() {
        return ResponseEntity.ok(accountService.getCurrentAccount());
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "get account (role MANAGER)")
    @GetMapping("/{accountId}")
    public ResponseEntity<AccountRes> getAccount(@PathVariable("accountId") Long accountId) {
        return ResponseEntity.ok(accountService.getAccount(accountId));
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "delete account (role MANAGER)")
    @DeleteMapping("/{accountId}")
    public ResponseEntity<String> deleteAccount(@PathVariable("accountId") Long accountId) {
        accountService.deleteAccount(accountId);
            return ResponseEntity.ok("Deleted");
    }

    @Operation(summary = "update account (current account)")
    @PutMapping("edit")
    public ResponseEntity<AccountRes> updateAccount(@Valid @RequestBody AccountUpdateDto accountUpdateDto) {
        return accountService.updateAccount(accountUpdateDto);
    }


    @PutMapping("/{accountId}/changePass")
    @Operation(summary = "change pass")
    public ResponseEntity<String> changePass(@PathVariable("accountId") Long accountId,@Valid @RequestBody ChangePassDto changePassDto) {
        accountService.changePass(accountId,changePassDto);
        return ResponseEntity.ok("Password changed successfully");
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "update role (role MANAGER)")
    @PutMapping("/{accountId}/updateRole")
    public ResponseEntity<String> updateRole(@PathVariable("accountId") Long accountId,@RequestBody RoleEnum role) {
        accountService.updateRole(accountId,role);
        return ResponseEntity.ok("Successfully");
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "activated or deactivated account (role MANAGER)")
    @PutMapping("/{accountId}/activated")
    public ResponseEntity<String> activatedAccount(@PathVariable("accountId") Long accountId) {
        if(accountId == 1){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Cannot deactivate this account");
        }
        Boolean handleActivateStatus = accountService.activatedAccount(accountId);
        return ResponseEntity.ok(handleActivateStatus ? "Account activated successfully" : "Account deactivated successfully");
    }

    @PreAuthorize("hasAnyRole('MANAGER')")
    @Operation(summary = "create an account (role MANAGER)")
    @PostMapping()
    public ResponseEntity<AccountRes> createAccount(@Valid @RequestBody CreateAccountDto createAccountDto) {
        return ResponseEntity.ok(accountService.createAccount(createAccountDto));
    }
}
