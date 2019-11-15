package com.xzg56.jg.modules.mst.costroute.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/5/30.
 */

@Getter
@Setter
public class CostRouteSearchModel extends IdEntity {
    private String fromProvinceCode;
    private String fromCityCode;
    private String fromDistrictCode;
    private String fromCountyCode;
    private String toProvinceCode;
    private String toCityCode;
    private String toDistrictCode;
    private String toCountyCode;
    private String validFlag;
    private String plateNum;
    private String trailerBelongType;
}
