package org.example.fashion_api.Models.StoresAddress;

import lombok.*;

@Getter
@Setter
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class StoresAddressRes {
    private String name;
    private String address;
    private String time;
    private String phone;
    private String api;
    private String city;
}
