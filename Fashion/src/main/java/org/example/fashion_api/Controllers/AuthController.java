package org.example.fashion_api.Controllers;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Mapper.AccountMapper;
import org.example.fashion_api.Models.Accounts.AccountLoginDto;
import org.example.fashion_api.Models.Accounts.AccountRegisterDto;
import org.example.fashion_api.Models.Accounts.AccountRes;
import org.example.fashion_api.Services.AccountService.AccountService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("auth")
public class AuthController {
    private final AccountService accountService;
    private final AccountMapper accountMapper;

    @PostMapping("/verifyLogin")
    public ResponseEntity<AccountRes> verifyLogin(@RequestBody AccountLoginDto loginRequest,
                                                  @RequestParam(value = "validRoles", required = false) List<String> validRoles,
                                                  @RequestHeader(value = "Internal-Access-Token", required = true) String accessToken) {
        // Kiểm tra token nội bộ
        if (!"VDSDCXCVX".equals(accessToken)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
        return ResponseEntity.ok(accountService.verifyLogin(loginRequest,validRoles));
    }

    @DeleteMapping("/logout")
    @Operation(summary = "Logout", description = "This is a logout API")
    public ResponseEntity<String> logout(@RequestBody String token) {
        accountService.Logout(token);
        return ResponseEntity.ok("Logout successful");
    }

    @Operation(summary = "register")
    @PostMapping("/register")
    public ResponseEntity<AccountRes> registerAccount(@Valid @RequestBody AccountRegisterDto accountRegisterDto) {
        return ResponseEntity.ok(accountService.registerAccount(accountRegisterDto));
    }

    @Operation(summary = "reset pass")
    @PutMapping("/resetPass")
    public ResponseEntity<String> resetPass(@RequestBody String email) {
        accountService.resetPass(email);
        return ResponseEntity.ok("New password has been sent to registered email");
    }
}
