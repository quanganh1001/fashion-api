package org.example.fashion_api.Configurations;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Exception.ExpiredJwtException;
import org.example.fashion_api.Exception.InvalidTokenException;
import org.example.fashion_api.Exception.JwtException;
import org.example.fashion_api.Models.UserCustomDetail;
import org.example.fashion_api.Services.JwtService.JwtService;
import org.example.fashion_api.Services.UserDetailServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

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

                if (jwtService.isTokenValid(jwt, userCustomDetail.getAccount().getId())) {
                    if (!jwtService.isTokenExpiredInDatabase(jwt, userCustomDetail.getAccount().getId())) {
                        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                                userCustomDetail,
                                null,
                                userCustomDetail.getAuthorities()
                        );
                        authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                    } else throw new ExpiredJwtException("Token");
                } else throw new InvalidTokenException("Token");
            }else throw new InvalidTokenException("Token");
        }catch (ExpiredJwtException  e){
            response.sendError(e.getStatus().value(), e.getMessage());
            return;
        }catch (InvalidTokenException  e){
            response.sendError(e.getStatus().value(), e.getMessage());
            return;
        }catch (JwtException  e){
            response.sendError(e.getStatus().value(), e.getMessage());
            return;
        }catch (Exception e){
            response.sendError(HttpStatus.UNAUTHORIZED.value(), e.getMessage());
            return;
        }
        filterChain.doFilter(request, response);


    }
}
