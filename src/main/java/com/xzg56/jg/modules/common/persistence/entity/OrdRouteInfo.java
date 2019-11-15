package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/4/28.
 */
@Getter
@Setter
@Table(name = "ord_route_info")
public class OrdRouteInfo extends IdEntity<OrdRouteInfo> {
    @Column(name = "order_no")
    private String orderNo;

    @Column(name = "zx_address_id")
    private String zxAddressId;

    @Column(name = "sequence")
    private int sequence;

    @Column(name = "address_type")
    private String addressType;

    @Column(name = "address_full")
    private String addressFull;

    @Column(name = "province_code")
    private String provinceCode;

    @Column(name = "city_code")
    private String cityCode;

    @Column(name = "district_code")
    private String districtCode;

    @Column(name = "county_code")
    private String countyCode;
}
