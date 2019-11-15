package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import org.apache.ibatis.type.Alias;

import javax.persistence.Column;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "price_contract")
public class PriceContract extends IdEntity<PriceContract> {
    private static final long serialVersionUID = 1L;

    @Column(name = "PRICE_CONTRACT_NO")
    private String priceContractNo;//价格协议号

    @Column(name = "CONTRACT_NAME")
    private String contractName;//协议名称

    @Column(name = "EFFECT_START_TIME")
    private Date effectStartTime;//协议有效开始日期

    @Column(name = "EFFECT_END_TIME")
    private Date effectEndTime;//协议有效结束日期

    @Column(name = "SETTLEMENT_TYPE")
    private String settlementType;//结算类型

    @Column(name = "SETTLEMENT_DAYS")
    private Integer settlementDays;//应到款天数（业务发生时间后）

    @Column(name = "PRICE_EDITABLE_FLAG")
    private String priceEditableFlag;//核准运费可修改标志

    @Column(name = "REMARKS")
    private String remarks;//备注

    @Column(name = "VALID_FLAG")
    private String validFlag;//有效标志

    public PriceContract() {
        init();
    }

    private void init() {
        this.settlementDays = 0;
    }

    public String getPriceContractNo() {
        return priceContractNo;
    }

    public void setPriceContractNo(String priceContractNo) {
        this.priceContractNo = priceContractNo;
    }

    public String getContractName() {
        return contractName;
    }

    public void setContractName(String contractName) {
        this.contractName = contractName;
    }

    public Date getEffectStartTime() {
        return effectStartTime;
    }

    public void setEffectStartTime(Date effectStartTime) {
        this.effectStartTime = effectStartTime;
    }

    public Date getEffectEndTime() {
        return effectEndTime;
    }

    public void setEffectEndTime(Date effectEndTime) {
        this.effectEndTime = effectEndTime;
    }

    public String getSettlementType() {
        return settlementType;
    }

    public void setSettlementType(String settlementType) {
        this.settlementType = settlementType;
    }

    public Integer getSettlementDays() {
        return settlementDays;
    }

    public void setSettlementDays(Integer settlementDays) {
        this.settlementDays = settlementDays;
    }

    public String getPriceEditableFlag() {
        return priceEditableFlag;
    }

    public void setPriceEditableFlag(String priceEditableFlag) {
        this.priceEditableFlag = priceEditableFlag;
    }

    public String getValidFlag() {
        return validFlag;
    }

    public void setValidFlag(String validFlag) {
        this.validFlag = validFlag;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
