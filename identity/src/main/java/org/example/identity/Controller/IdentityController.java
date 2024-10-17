package org.example.identity.Controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.example.identity.Models.Accounts.AccountLoginDto;
import org.example.identity.Models.Accounts.AccountRes;
import org.example.identity.Models.JwtToken.JwtTokenRes;
import org.example.identity.Serivces.AuthService.AuthService;
import org.example.identity.Serivces.JwtService.JwtService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("identity")
public class IdentityController {

    private final JwtService jwtService;

    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<JwtTokenRes> customerLogin(@RequestBody AccountLoginDto loginRequest) throws Exception {
        return new ResponseEntity<>(authService.CustomerLogin(loginRequest), HttpStatus.OK);
    }

    @PostMapping("/admin/login")
    public ResponseEntity<JwtTokenRes> adminLogin( @RequestBody AccountLoginDto loginRequest) throws Exception {
        return new ResponseEntity<>(authService.AdminLogin(loginRequest), HttpStatus.OK);
    }

    @DeleteMapping("/logout")
    public ResponseEntity<String> logout(@RequestBody String token) {
        jwtService.deleteToken(token);
        return ResponseEntity.ok("Logout successful");
    }

    @PostMapping("/genToken")
    public ResponseEntity<JwtTokenRes> genToken(@RequestBody AccountRes accountRes,
                                                @RequestHeader(value = "Internal-Access-Token", required = true) String accessToken){
        // Kiểm tra token nội bộ
        if (!"VDSDCXCVX".equals(accessToken)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        return ResponseEntity.ok(jwtService.tokenRes(accountRes));
    }

    @GetMapping("/verifyToken")
    public ResponseEntity<String> verifyToken(@RequestParam String jwt,
                                            @RequestParam Long id,@RequestHeader(value = "Internal-Access-Token", required = true) String accessToken){
        // Kiểm tra token nội bộ
        if (!"VDSDCXCVX".equals(accessToken)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
        return jwtService.verifyToken(jwt,id);
    }

    @PutMapping("/refreshToken")
    public ResponseEntity<JwtTokenRes> refreshToken(HttpServletRequest req, HttpServletResponse res)  {
        return new ResponseEntity<>(jwtService.RefreshToken(req, res), HttpStatus.OK);
    }

    @DeleteMapping("findByToken")
    public ResponseEntity<Void> deleteToken(String token,
                                              @RequestHeader(value = "Internal-Access-Token", required = true) String accessToken){
        // Kiểm tra token nội bộ
        if (!"VDSDCXCVX".equals(accessToken)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
         jwtService.deleteToken(token);
        return ResponseEntity.ok().build();
    }

}
