package com.xzg56.jg.modules.mst.pricecontract.model;


import com.xzg56.core.persistence.IdEntity;
import org.apache.ibatis.type.Alias;

/**
 * Created by wjn on 2019/1/28
 * @author wjn
 */
@Alias("mstPriceContractModel")
public class PriceContractModel extends IdEntity<PriceContractModel> {
    private static final long serialVersionUID = 8599546905264588297L;

    private String priceContractNoLink;
    private String contractName;
    private String effectStartTime;
    private String effectEndTime;
    private String settlementType;
    private String settlementTypeName;
    private String settlementDays;
    private String outHctxFee;
    private String remarks;
    private String validFlag;
    private String ordInputGroup;
    private String secondEnableFlag;
    private String portMiscellDays;
    private String chartingDays;
    private String createTimeFmt;
    private String updateTimeFmt;
    private String priceContractNo;
    private String binsType;
    private String ioType;
    private String effectiveStatus;

    public String getPriceContractNoLink() {
        return priceContractNoLink;
    }

    public void setPriceContractNoLink(String priceContractNoLink) {
        this.priceContractNoLink = priceContractNoLink;
    }

    public String getContractName() {
        return contractName;
    }

    public void setContractName(String contractName) {
        this.contractName = contractName;
    }

    public String getEffectStartTime() {
        return effectStartTime;
    }

    public void setEffectStartTime(String effectStartTime) {
        this.effectStartTime = effectStartTime;
    }

    public String getEffectEndTime() {
        return effectEndTime;
    }

    public void setEffectEndTime(String effectEndTime) {
        this.effectEndTime = effectEndTime;
    }

    public String getOutHctxFee() {
        return outHctxFee;
    }

    public void setOutHctxFee(String outHctxFee) {
        this.outHctxFee = outHctxFee;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getValidFlag() {
        return validFlag;
    }

    public void setValidFlag(String validFlag) {
        this.validFlag = validFlag;
    }

    public String getPriceContractNo() {
        return priceContractNo;
    }

    public void setPriceContractNo(String priceContractNo) {
        this.priceContractNo = priceContractNo;
    }

    public String getBinsType() {
        return binsType;
    }

    public void setBinsType(String binsType) {
        this.binsType = binsType;
    }

    public String getIoType() {
        return ioType;
    }

    public void setIoType(String ioType) {
        this.ioType = ioType;
    }

    public String getSettlementType() {
        return settlementType;
    }

    public void setSettlementType(String settlementType) {
        this.settlementType = settlementType;
    }

    public String getSettlementTypeName() {
        return settlementTypeName;
    }

    public void setSettlementTypeName(String settlementTypeName) {
        this.settlementTypeName = settlementTypeName;
    }

    public String getSettlementDays() {
        return settlementDays;
    }

    public void setSettlementDays(String settlementDays) {
        this.settlementDays = settlementDays;
    }

    public String getOrdInputGroup() {
        return ordInputGroup;
    }

    public void setOrdInputGroup(String ordInputGroup) {
        this.ordInputGroup = ordInputGroup;
    }

    public String getSecondEnableFlag() {
        return secondEnableFlag;
    }

    public void setSecondEnableFlag(String secondEnableFlag) {
        this.secondEnableFlag = secondEnableFlag;
    }

    public String getEffectiveStatus() {
        return effectiveStatus;
    }

    public void setEffectiveStatus(String effectiveStatus) {
        this.effectiveStatus = effectiveStatus;
    }

    public String getPortMiscellDays() {
        return portMiscellDays;
    }

    public void setPortMiscellDays(String portMiscellDays) {
        this.portMiscellDays = portMiscellDays;
    }

    public String getChartingDays() {
        return chartingDays;
    }

    public void setChartingDays(String chartingDays) {
        this.chartingDays = chartingDays;
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
}
