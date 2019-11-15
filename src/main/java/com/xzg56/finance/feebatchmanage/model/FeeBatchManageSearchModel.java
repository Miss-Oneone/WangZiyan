package com.xzg56.finance.feebatchmanage.model;


import com.xzg56.core.persistence.IdEntity;

/**
 * @author wjn
 * @date 2019/1/3
 */
public class FeeBatchManageSearchModel extends IdEntity<FeeBatchManageModel> {
    private static final long serialVersionUID = 8150565649419917719L;

    private String drvordTimeFrom;
    private String drvordTimeTo;
    private String relatedCompyCode;
    private String cusCode;
    private String blNo;
    private String contnNo;
    private String containerType;
    private String binsApprovalFlag;
    private String createTimeFrom;
    private String createTimeTo;
    private String paymentType;
    private String piCode;
    private String feeStatus;
    private String sign;
    private String amount;

    public String getDrvordTimeFrom() {
        return drvordTimeFrom;
    }

    public void setDrvordTimeFrom(String drvordTimeFrom) {
        this.drvordTimeFrom = drvordTimeFrom;
    }

    public String getDrvordTimeTo() {
        return drvordTimeTo;
    }

    public void setDrvordTimeTo(String drvordTimeTo) {
        this.drvordTimeTo = drvordTimeTo;
    }

    public String getRelatedCompyCode() {
        return relatedCompyCode;
    }

    public void setRelatedCompyCode(String relatedCompyCode) {
        this.relatedCompyCode = relatedCompyCode;
    }

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode;
    }

    public String getBlNo() {
        return blNo;
    }

    public void setBlNo(String blNo) {
        this.blNo = blNo;
    }

    public String getContnNo() {
        return contnNo;
    }

    public void setContnNo(String contnNo) {
        this.contnNo = contnNo;
    }

    public String getContainerType() {
        return containerType;
    }

    public void setContainerType(String containerType) {
        this.containerType = containerType;
    }

    public String getBinsApprovalFlag() {
        return binsApprovalFlag;
    }

    public void setBinsApprovalFlag(String binsApprovalFlag) {
        this.binsApprovalFlag = binsApprovalFlag;
    }

    public String getCreateTimeFrom() {
        return createTimeFrom;
    }

    public void setCreateTimeFrom(String createTimeFrom) {
        this.createTimeFrom = createTimeFrom;
    }

    public String getCreateTimeTo() {
        return createTimeTo;
    }

    public void setCreateTimeTo(String createTimeTo) {
        this.createTimeTo = createTimeTo;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getPiCode() {
        return piCode;
    }

    public void setPiCode(String piCode) {
        this.piCode = piCode;
    }

    public String getFeeStatus() {
        return feeStatus;
    }

    public void setFeeStatus(String feeStatus) {
        this.feeStatus = feeStatus;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }
}
