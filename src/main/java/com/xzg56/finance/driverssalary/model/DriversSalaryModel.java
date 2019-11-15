package com.xzg56.finance.driverssalary.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/5/28.
 */

@Getter
@Setter
public class DriversSalaryModel extends BaseModel{
    private String driverCode;
    private String driverName;
    private String plateNum;
    private String count;
    private String stdKmQty;
    private String stdOilQty;
    private String oilMass;
    private String actualOil;
    private String baseSalary;
    private String oilSubsidy;
    private String otherSubsidy;
    private String totalSalary;
    private String finalSalary;
    private String leaveDays;
    private String addDutyRewardAmount;
    private String addOtherAmount;
    private String deductSsAmount;
    private String deductRiskAmount;
    private String deductLoanAmount;
    private String deductOtherAmount;
    private String deductTaxAmount;
    private String orgBaseSalaryAmount;
    private String baseSalaryAmount;
    private String driverType;
    private String quitFlag;
    private String transportType;
    private String transportTypeCd;
    private String baseSubsidy;
    private String adjustKm;
    private String extraWorkSubsidy;
}
