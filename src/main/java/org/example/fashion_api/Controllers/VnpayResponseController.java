package org.example.fashion_api.Controllers;

import io.swagger.annotations.Api;
import io.swagger.v3.oas.annotations.Hidden;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Configurations.VnpayConfig;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@RestController
public class VnpayResponseController {
    @Autowired
    private InvoiceRepo invoiceRepo;

    @Value("${frontend.url}")
    private String frontendUrl;

    @GetMapping("/vnpay/response")
    @Hidden
    @Transactional
    public ResponseEntity<String> getVnpayResponse(HttpServletRequest request)  {

        Map fields = new HashMap();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII);
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII);
            if ((fieldValue != null) && (!fieldValue.isEmpty())) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");

        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        String signValue = VnpayConfig.hashAllFields(fields);

        if (!signValue.equals(vnp_SecureHash)) {
            throw new BadRequestException("Signature doesn't match");
        }

        //get invoiceId
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String invoiceId = vnp_TxnRef.substring(0, vnp_TxnRef.length() - 5);



        if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
            //if payment success -> change status invoice
            invoiceRepo.changeStatusIsPaid(Long.parseLong(invoiceId));

            return ResponseEntity.status(HttpStatus.FOUND)
                    .header(HttpHeaders.LOCATION, frontendUrl + "response?success=1")
                    .build();

        }

        //if payment fail -> delete invoice
        invoiceRepo.deleteById(Long.parseLong(invoiceId));
        return ResponseEntity.status(HttpStatus.FOUND)
                .header(HttpHeaders.LOCATION, frontendUrl  + "response?success=0")
                .build();


    }



}

