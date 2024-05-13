package org.example.fashion_api.Controllers;


import com.cloudinary.api.exceptions.BadRequest;
import jakarta.servlet.http.HttpServletRequest;
import org.example.fashion_api.Configurations.VnpayConfig;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Repositories.InvoiceRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@RestController
public class VnpayResponseController {
    @Autowired
    private InvoiceRepo invoiceRepo;

    @GetMapping("/vnpay/response")
    public ResponseEntity<String> getVnpayResponse(HttpServletRequest request) throws BadRequest {
        //Begin process return from VNPAY
        Map fields = new HashMap();
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = (String) params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
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

        System.out.println(request.getParameter("vnp_SecureHashType"));
        System.out.println(request.getParameter("vnp_SecureHash"));
        System.out.println(request.getParameter("vnp_TxnRef"));

        invoiceRepo.deleteById(request.getParameter("vnp_TxnRef"));
        return ResponseEntity.ok().body(signValue);
//        if (signValue.equals(vnp_SecureHash)) {
//            if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
//                String invoiceId = request.getParameter("vnp_TxnRef");
//
//                invoiceRepo.changeStatusIsPaid(invoiceId);
//
//                return ResponseEntity.ok("Payment Success!");
//            } else {
//                throw new BadRequestException("Payment failed");
//            }
//
//        } else {
//            throw new BadRequestException("Signature doesn't match");
//        }
    }
}
