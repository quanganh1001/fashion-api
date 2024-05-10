package org.example.fashion_api.Enum;

public enum InvoiceStatusEnum {
    CANCEL(0),
    NEW(1),
    PROCESS(2),
    ORDER_CREATED(3),
    DELIVERING(4),
    SUCCESS(5),
    RETURN(6);

    private final int value;

    InvoiceStatusEnum(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
