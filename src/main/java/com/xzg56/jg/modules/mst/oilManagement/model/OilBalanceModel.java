package com.xzg56.jg.modules.mst.oilManagement.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/17.
 */

@Getter
@Setter
public class OilBalanceModel extends BaseModel{
    private String driverName;
    private String plateNum;
    private String operationTime;
    private String gpsBeginDate;
    private String gpsEndDate;
    private String gpsSumKm;
    private String addLiters;
    private String litersPerHKm;
    private String driverCode;

    private String mileSum;
    private String beginTime;
    private String endTime;
}
