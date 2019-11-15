package com.xzg56.jg.modules.mst.costroute.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/5/30.
 */

@Getter
@Setter
public class CostRouteModel extends BaseModel {
    private String id;
    private String fromProvinceCode;
    private String fromCityCode;
    private String fromDistrictCode;
    private String fromCountyCode;
    private String toProvinceCode;
    private String toCityCode;
    private String toDistrictCode;
    private String toCountyCode;
    private String distanceAdjKm;
    private String stdDrvSalPrice;
    private String validFlag;
    private String fromProvinceName;
    private String fromCityName;
    private String fromDistrictName;
    private String fromCountyName;
    private String toProvinceName;
    private String toCityName;
    private String toDistrictName;
    private String toCountyName;
    private String remarks;
    private String trailerBelongType;
}
