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
public class PriceContractModel extends BaseModel{

    private int priceContractId;
    private String priceContractNo;
    private String contractName;
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
    private String remarks;
    private String rCusBfPrice;
    private String rCusBfPriceNoTax;
    private String roundTripFlag;
    private String roundTripFlagName;
    private String overweightPrice;
    private String limitWeight;

    private String stdDrvSalPrice;
    private String distanceAdjKm;
}
