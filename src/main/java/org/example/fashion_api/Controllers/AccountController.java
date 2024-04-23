package org.example.fashion_api.Controllers;

import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.example.fashion_api.Models.Account.AccountRegisterDto;
import org.example.fashion_api.Models.Account.AccountRes;
import org.example.fashion_api.Models.UserCustomDetail;
import org.example.fashion_api.Repositories.AccountRepo;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("account")
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
    public AccountRes registerAccount(@RequestBody AccountRegisterDto accountRegisterDto) {
        return accountService.registerAccount(accountRegisterDto);
    }
}
