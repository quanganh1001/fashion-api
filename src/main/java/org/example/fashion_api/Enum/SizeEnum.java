package org.example.fashion_api.Enum;

import lombok.Getter;

@Getter
public enum SizeEnum {
    SIZE_S("Size S"),
    SIZE_M("Size M"),
    SIZE_L("Size L"),
    SIZE_XL("Size XL"),
    SIZE_XXL("Size XXL"),
    SIZE_29("Size 29"),
    SIZE_30("Size 30"),
    SIZE_31("Size 31"),
    SIZE_32("Size 32"),
    SIZE_33("Size 33"),
    SIZE_38("Size 38"),
    SIZE_39("Size 39"),
    SIZE_40("Size 40"),
    SIZE_41("Size 41"),
    SIZE_42("Size 42")
    ;

    private final String size;

    SizeEnum(String size) {
        this.size = size;
    }
}
