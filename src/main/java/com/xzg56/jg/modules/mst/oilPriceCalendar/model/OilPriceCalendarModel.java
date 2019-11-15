package com.xzg56.jg.modules.mst.oilPriceCalendar.model;


import com.xzg56.core.persistence.IdEntity;

/**
 * Created by zxp on 2019/4/22.
 */
public class OilPriceCalendarModel extends IdEntity<OilPriceCalendarModel> {

    private static final long serialVersionUID = -1624863294429390929L;

    private String effectiveDate;
    private String oilPriceTypeLabel;
    private String oilTypeLabel;
    private String approvalStatusLabel;
    private String oilPriceType;
    private String oilType;
    private String approvalStatus;
    private String avgPrice;
    private String lastPrice;
    private String remarks;
    private String pageType;
    private String innerFlag;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(String effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public String getOilPriceTypeLabel() {
        return oilPriceTypeLabel;
    }

    public void setOilPriceTypeLabel(String oilPriceTypeLabel) {
        this.oilPriceTypeLabel = oilPriceTypeLabel;
    }

    public String getOilTypeLabel() {
        return oilTypeLabel;
    }

    public void setOilTypeLabel(String oilTypeLabel) {
        this.oilTypeLabel = oilTypeLabel;
    }

    public String getApprovalStatusLabel() {
        return approvalStatusLabel;
    }

    public void setApprovalStatusLabel(String approvalStatusLabel) {
        this.approvalStatusLabel = approvalStatusLabel;
    }

    public String getOilPriceType() {
        return oilPriceType;
    }

    public void setOilPriceType(String oilPriceType) {
        this.oilPriceType = oilPriceType;
    }

    public String getOilType() {
        return oilType;
    }

    public void setOilType(String oilType) {
        this.oilType = oilType;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getAvgPrice() {
        return avgPrice;
    }

    public void setAvgPrice(String avgPrice) {
        this.avgPrice = avgPrice;
    }

    public String getLastPrice() {
        return lastPrice;
    }

    public void setLastPrice(String lastPrice) {
        this.lastPrice = lastPrice;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getPageType() {
        return pageType;
    }

    public void setPageType(String pageType) {
        this.pageType = pageType;
    }

    public String getInnerFlag() {
        return innerFlag;
    }

    public void setInnerFlag(String innerFlag) {
        this.innerFlag = innerFlag;
    }
}
