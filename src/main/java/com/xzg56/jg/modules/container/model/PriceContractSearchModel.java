package com.xzg56.jg.modules.container.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/26.
 */

@Getter
@Setter
public class PriceContractSearchModel extends BaseModel {
    private String priceContractNo;
    private String chargingType;
    private String fromProvinceCode;
    private String fromCityCode;
    private String fromDistrictCode;
    private String fromCountyCode;
    private String toProvinceCode;
    private String toCityCode;
    private String toDistrictCode;
    private String toCountyCode;
    private String containerType;
    private String levelCode;
    private String binsType;
    private String ioType;
    private String roundTripFlag;
}
