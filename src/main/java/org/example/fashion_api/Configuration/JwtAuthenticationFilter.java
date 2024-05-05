package org.example.fashion_api.Configuration;

import com.auth0.jwt.exceptions.TokenExpiredException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Exception.ExpiredJwtException;
import org.example.fashion_api.Exception.InvalidTokenException;
import org.example.fashion_api.Models.UserCustomDetail;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.example.fashion_api.Services.UserDetailServiceImpl;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.text.ParseException;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;

    private final UserDetailServiceImpl userDetailService;


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        final String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        final String jwt;
        final String username;
        jwt = authHeader.substring(7);

        try {
            username = jwtService.extractUsername(jwt);

            if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                UserCustomDetail userCustomDetail = (UserCustomDetail) this.userDetailService.loadUserByUsername(username);

                if (jwtService.isTokenValid(jwt, userCustomDetail.getAccount().getAccountId())) {

                    if (!jwtService.isTokenExpired(jwt, userCustomDetail.getAccount().getAccountId())) {
                        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                                userCustomDetail,
                                null,
                                userCustomDetail.getAuthorities()
                        );
                        authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                    } else throw new ExpiredJwtException();

                } else throw new InvalidTokenException();
            }
        } catch (ParseException e) {
            throw new InvalidTokenException();
        }


        filterChain.doFilter(request, response);

    }
}
