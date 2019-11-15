package com.xzg56.finance.driverssalary.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wzr on 2019/6/12
 */

@Getter
@Setter
public class DriversSalaryDetailModel extends BaseModel{
    private String driverName;
    private String plateNum;
    private String tripFlag;
    private String drvordTime;
    private String contnNo;
    private String departurePlace;
    private String arrivalPlace;
    private String goodsName;
    private String stdKmQty;
    private String adjustKm;
    private String stdOilQty;
    private String actualOil;
    private String baseSalary;
    private String otherSubsidy;
    private String totalAmount;
    private String remarks;
    private String liters;
    private String transportType;
}
