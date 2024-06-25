package org.example.fashion_api.Enum;

import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;

@Getter
public enum ImgSizeEnum {
    IMAGE_1("Size áo polo", "https://res.cloudinary.com/dmmvhjl0m/image/upload/v1719336198/stguog9muykv77rqy53w.webp"),
    IMAGE_2("Size áo sơ mi", "https://res.cloudinary.com/dmmvhjl0m/image/upload/v1719336198/nyuapgnchfsdoxijnzcn.webp"),
    IMAGE_3("Size quần âu", "https://res.cloudinary.com/dmmvhjl0m/image/upload/v1719336198/i6psbisy1kedraztttuw.webp"),
    IMAGE_4("Size quần jean + kaki", "https://res.cloudinary.com/dmmvhjl0m/image/upload/v1719336198/gnd8iakarctefwwrccp8.jpg"),
    IMAGE_5("Size áo khoác", "https://res.cloudinary.com/dmmvhjl0m/image/upload/v1719336199/yy7moysyqvxf3ulyp4mt.webp");

    private final String name;
    private final String url;

    ImgSizeEnum(String name, String url) {
        this.name = name;
        this.url = url;
    }

    @JsonValue
    public String getUrl() {
        return url;
    }
}
