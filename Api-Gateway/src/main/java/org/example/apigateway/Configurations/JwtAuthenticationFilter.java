package org.example.apigateway.Configurations;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.example.apigateway.Exception.ExpiredJwtException;
import org.example.apigateway.Exception.InvalidTokenException;
import org.example.apigateway.Models.UserCustomDetail;
import org.example.apigateway.Repositories.IdentityClient;
import org.example.apigateway.Service.JwtService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.util.Objects;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter implements WebFilter {


    private final IdentityClient identityClient;
    private final UserDetailsService userDetailsService;
    private final JwtService jwtService;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
        final String authHeader = exchange.getRequest().getHeaders().getFirst("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return chain.filter(exchange);
        }

        final String jwt = authHeader.substring(7);

        return Mono.just(jwt)
                .flatMap(token -> {
                    try {
                        String phone = jwtService.extractPhone(token);
                        UserCustomDetail userCustomDetail = (UserCustomDetail) userDetailsService.loadUserByUsername(phone);
                        if (phone != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                            String res = identityClient.verifyToken(token,
                                    userCustomDetail.getAccount().getId());
                            if (res.equals("ok")) {
                                UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                                        userCustomDetail,
                                        null,
                                        userCustomDetail.getAuthorities()
                                );
//                                authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(exchange.getRequest()));
//                                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                                // Sau khi xác thực, chuyển tiếp thông tin người dùng và quyền xuống microservice
                                ServerHttpRequest request = exchange.getRequest().mutate()
                                        .header("X-Authenticated-User", phone)
                                        .header("X-User-Roles", String.join(",", userCustomDetail.getAuthorities().stream()
                                                .map(GrantedAuthority::getAuthority).collect(Collectors.toList())))
                                        .build();
                                ServerWebExchange newExchange = exchange.mutate().request(request).build();
                                return chain.filter(newExchange);
                            }
                        } else {
                            throw new InvalidTokenException("Token");
                        }
                    } catch (ExpiredJwtException e) {
                        exchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
                        return exchange.getResponse().setComplete();
                    } catch (InvalidTokenException e) {
                        exchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
                        return exchange.getResponse().setComplete();
                    } catch (Exception e) {
                        exchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
                        return exchange.getResponse().setComplete();
                    }

                    return chain.filter(exchange);
                });
    }
}
