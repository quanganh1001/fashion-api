package org.example.identity.Controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.example.identity.Models.Accounts.AccountRes;
import org.example.identity.Models.JwtToken.JwtTokenRes;
import org.example.identity.Serivces.JwtService.JwtService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("identity")
public class IdentityController {

    private final JwtService jwtService;

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


//    @PostMapping("/addAuthentication")
//    public void refreshToken(UsernamePasswordAuthenticationToken authenticationToken)  {
//        authenticationManager.authenticate(authenticationToken);
//        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
//    }
}
