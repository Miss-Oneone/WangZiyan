package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/5/30.
 */

@Getter
@Setter
@Table(name = "mst_cost_route")
public class CostRoute extends IdEntity<CostRoute> {

    @Column(name = "from_province_code")
    private String fromProvinceCode;
    @Column(name = "from_city_code")
    private String fromCityCode;
    @Column(name = "from_district_code")
    private String fromDistrictCode;
    @Column(name = "from_county_code")
    private String fromCountyCode;
    @Column(name = "to_province_code")
    private String toProvinceCode;
    @Column(name = "to_city_code")
    private String toCityCode;
    @Column(name = "to_district_code")
    private String toDistrictCode;
    @Column(name = "to_county_code")
    private String toCountyCode;
    @Column(name = "distance_adj_km")
    private String distanceAdjKm;
    @Column(name = "std_drv_sal_price")
    private String stdDrvSalPrice;
    @Column(name = "remarks")
    private String remarks;
    @Column(name = "valid_flag")
    private String validFlag;
    @Column(name = "trailer_belong_type")
    private String trailerBelongType;
}

