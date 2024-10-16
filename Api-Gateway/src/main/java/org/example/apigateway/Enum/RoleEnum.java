package org.example.apigateway.Enum;

import lombok.Getter;

@Getter
public enum RoleEnum {
    ROLE_EMPLOYEE("Nhân viên"),
    ROLE_MANAGER("Quản lý"),
    ROLE_CUSTOMER("Khách hàng");

    private final String role;

    RoleEnum(String role) {
        this.role = role;
    }
}
