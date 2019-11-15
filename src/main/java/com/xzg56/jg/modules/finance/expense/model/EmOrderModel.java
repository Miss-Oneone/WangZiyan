package com.xzg56.jg.modules.finance.expense.model;


import com.xzg56.core.persistence.BaseModel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * 费用管理
 *
 * @author zyq 2019/03/28
 *
 */
@Getter
@Setter
public class EmOrderModel extends BaseModel {
    private static final long serialVersionUID = -7672346374735714222L;

    private String orderNo;
    private String cusCode;
    private String cusName;
    private String driverCode;
    private String driverName;
    private String blNo;
    private String contnNo;
    private String sealNo;
    private String drvordTime;
    private String interGoods;
    private String exterGoods;
    private String plateNum;
    private String frameNum;
    private String frameCardId;
    private String acceptOrderFlag;
    private String acceptOrderLabel;
    private String chargingType;
    private String chargingName;
    private String quantity;
    private String unitPrice;
    private String containerType;
    private String documentNo;
    private String batchNo;
    private String transportType;
    private String departurePlace;
    private String arrivalPlace;
    private String status;
    private String remarks;
}
