package org.example.fashion_api.Enum;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;

@Getter
public enum InvoiceStatusEnum {
    CANCEL(0,"Đơn hủy"),
    NEW(1,"Đơn mới"),
    PROCESS(2,"Đơn đang xử lý"),
    ORDER_CREATED(3,"Đơn đã lên"),
    DELIVERING(4,"Đơn đang chuyển"),
    SUCCESS(5,"Đơn thành công"),
    RETURN(6, "Đơn hoàn");

    private final int value;
    private final String des;


    InvoiceStatusEnum(int value,String des) {
        this.value = value;
        this.des = des;
    }

    @JsonValue
    public String getDes() {
        return des;
    }


}
