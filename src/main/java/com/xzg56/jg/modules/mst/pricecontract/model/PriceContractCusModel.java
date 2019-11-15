package com.xzg56.jg.modules.mst.pricecontract.model;


import com.xzg56.core.persistence.IdEntity;

/**
 * Created by wjn on 2019/1/28
 * @author wjn
 */

public class PriceContractCusModel extends IdEntity<PriceContractCusModel> {


    private static final long serialVersionUID = 680792790538849604L;


    private String priceContractNo;
    private String cusCode;
    private String cusName;
    private String salesManId;
    private String salesMan;
    private String createTimeFmt;
    private String updateTimeFmt;

    public String getPriceContractNo() {
        return priceContractNo;
    }

    public void setPriceContractNo(String priceContractNo) {
        this.priceContractNo = priceContractNo;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getSalesMan() {
        return salesMan;
    }

    public void setSalesMan(String salesMan) {
        this.salesMan = salesMan;
    }

    public String getCreateTimeFmt() {
        return createTimeFmt;
    }

    public void setCreateTimeFmt(String createTimeFmt) {
        this.createTimeFmt = createTimeFmt;
    }

    public String getUpdateTimeFmt() {
        return updateTimeFmt;
    }

    public void setUpdateTimeFmt(String updateTimeFmt) {
        this.updateTimeFmt = updateTimeFmt;
    }

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode;
    }

    public String getSalesManId() {
        return salesManId;
    }

    public void setSalesManId(String salesManId) {
        this.salesManId = salesManId;
    }
}
