package com.xzg56.jg.modules.mst.oilPriceCalendar.model;


import com.xzg56.core.persistence.IdEntity;

/**
 * Created by zxp on 2019/4/22.
 */
public class OilPriceCalendarSearchModel extends IdEntity<OilPriceCalendarSearchModel> {

    private static final long serialVersionUID = -1624863294429390929L;

    private String fuelPurchaseId;
    private String createTimeFr;
    private String createTimeTo;
    private String createBy;
    private String compyCode;
    private String effectiveDateFr;
    private String effectiveDateTo;
    private String approvalStatus;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getFuelPurchaseId() {
        return fuelPurchaseId;
    }

    public void setFuelPurchaseId(String fuelPurchaseId) {
        this.fuelPurchaseId = fuelPurchaseId;
    }

    public String getCreateTimeFr() {
        return createTimeFr;
    }

    public void setCreateTimeFr(String createTimeFr) {
        this.createTimeFr = createTimeFr;
    }

    public String getCreateTimeTo() {
        return createTimeTo;
    }

    public void setCreateTimeTo(String createTimeTo) {
        this.createTimeTo = createTimeTo;
    }

    @Override
    public String getCreateBy() {
        return createBy;
    }

    @Override
    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCompyCode() {
        return compyCode;
    }

    public void setCompyCode(String compyCode) {
        this.compyCode = compyCode;
    }

    public String getEffectiveDateFr() {
        return effectiveDateFr;
    }

    public void setEffectiveDateFr(String effectiveDateFr) {
        this.effectiveDateFr = effectiveDateFr;
    }

    public String getEffectiveDateTo() {
        return effectiveDateTo;
    }

    public void setEffectiveDateTo(String effectiveDateTo) {
        this.effectiveDateTo = effectiveDateTo;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }
}
