package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "price_contract_cus")
public class PriceContractCus extends IdEntity<PriceContractCus> {
    private static final long serialVersionUID = 1L;

    @Column(name = "PRICE_CONTRACT_NO")
    private String priceContractNo;//价格协议号

    @Column(name = "CUS_CODE")
    private String cusCode;//客户编码

    @Column(name = "VALID_FLAG")
    private String validFlag;//有效标志

    public PriceContractCus() {
        init();
    }

    private void init() {

    }

    public String getPriceContractNo() {
        return priceContractNo;
    }

    public void setPriceContractNo(String priceContractNo) {
        this.priceContractNo = priceContractNo;
    }

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode;
    }

    public String getValidFlag() {
        return validFlag;
    }

    public void setValidFlag(String validFlag) {
        this.validFlag = validFlag;
    }
}
