package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import com.xzg56.utility.StringUtils;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "price_contract_bf")
public class PriceContractBf extends IdEntity<PriceContractBf> {
    private static final long serialVersionUID = 1L;

    @Column(name = "PRICE_CONTRACT_NO")
    private String priceContractNo;//价格协议号

    @Column(name = "CHARGING_TYPE")
    private String chargingType;//计费方式

    @Column(name = "bins_type")
    private String binsType;//内外贸

    @Column(name = "io_type")
    private String ioType;//进出口

    @Column(name = "FROM_PROVINCE_CODE")
    private String fromProvinceCode;//省编码

    @Column(name = "FROM_CITY_CODE")
    private String fromCityCode;//市编码

    @Column(name = "FROM_DISTRICT_CODE")
    private String fromDistrictCode;//区/县编码

    @Column(name = "FROM_COUNTY_CODE")
    private String fromCountyCode;//乡镇编码

    @Column(name = "TO_PROVINCE_CODE")
    private String ToProvinceCode;//省编码

    @Column(name = "TO_CITY_CODE")
    private String ToCityCode;//市编码

    @Column(name = "TO_DISTRICT_CODE")
    private String ToDistrictCode;//区/县编码

    @Column(name = "TO_COUNTY_CODE")
    private String ToCountyCode;//乡镇编码

    @Column(name = "CONTAINER_TYPE")
    private String containerType;//集装箱价格等级类型

    @Column(name = "REMARKS")
    private String remarks;//备注

    @Column(name = "R_CUS_BF_PRICE")
    private String rCusBfPrice;//客户核定-应收-单价（元）

    @Column(name = "r_cus_bf_price_no_tax")
    private String rCusBfPriceNoTax;//客户核定-应收-不含税单价（元）

    @Column(name = "valid_flag")
    private String validFlag;//有效标志

    @Column(name = "round_trip_flag")
    private String roundTripFlag;//双程标志

    @Column(name = "overweight_price")
    private String overweightPrice;//超重费用（元/每吨）

    @Column(name = "limit_weight")
    private String limitWeight;//超重阈值（吨）

    public PriceContractBf() {
        init();
    }

    private void init() {
        this.validFlag = "Y";
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getPriceContractNo() {
        return priceContractNo;
    }

    public void setPriceContractNo(String priceContractNo) {
        this.priceContractNo = priceContractNo;
    }

    public String getContainerType() {
        return containerType;
    }

    public void setContainerType(String containerType) {
        this.containerType = containerType;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getrCusBfPrice() {
        return StringUtils.replace(rCusBfPrice,",","");
    }

    public void setrCusBfPrice(String rCusBfPrice) {
        this.rCusBfPrice = rCusBfPrice;
    }

    public String getrCusBfPriceNoTax() {
        return rCusBfPriceNoTax;
    }

    public void setrCusBfPriceNoTax(String rCusBfPriceNoTax) {
        this.rCusBfPriceNoTax = rCusBfPriceNoTax;
    }

    public String getValidFlag() {
        return validFlag;
    }

    public void setValidFlag(String validFlag) {
        this.validFlag = validFlag;
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

    public String getChargingType() {
        return chargingType;
    }

    public void setChargingType(String chargingType) {
        this.chargingType = chargingType;
    }

    public String getFromProvinceCode() {
        return fromProvinceCode;
    }

    public void setFromProvinceCode(String fromProvinceCode) {
        this.fromProvinceCode = fromProvinceCode;
    }

    public String getFromCityCode() {
        return fromCityCode;
    }

    public void setFromCityCode(String fromCityCode) {
        this.fromCityCode = fromCityCode;
    }

    public String getFromDistrictCode() {
        return fromDistrictCode;
    }

    public void setFromDistrictCode(String fromDistrictCode) {
        this.fromDistrictCode = fromDistrictCode;
    }

    public String getFromCountyCode() {
        return fromCountyCode;
    }

    public void setFromCountyCode(String fromCountyCode) {
        this.fromCountyCode = fromCountyCode;
    }

    public String getToProvinceCode() {
        return ToProvinceCode;
    }

    public void setToProvinceCode(String toProvinceCode) {
        ToProvinceCode = toProvinceCode;
    }

    public String getToCityCode() {
        return ToCityCode;
    }

    public void setToCityCode(String toCityCode) {
        ToCityCode = toCityCode;
    }

    public String getToDistrictCode() {
        return ToDistrictCode;
    }

    public void setToDistrictCode(String toDistrictCode) {
        ToDistrictCode = toDistrictCode;
    }

    public String getToCountyCode() {
        return ToCountyCode;
    }

    public void setToCountyCode(String toCountyCode) {
        ToCountyCode = toCountyCode;
    }

    public String getRoundTripFlag() {
        return roundTripFlag;
    }

    public void setRoundTripFlag(String roundTripFlag) {
        this.roundTripFlag = roundTripFlag;
    }

    public String getOverweightPrice() {
        return overweightPrice;
    }

    public void setOverweightPrice(String overweightPrice) {
        this.overweightPrice = overweightPrice;
    }

    public String getLimitWeight() {
        return limitWeight;
    }

    public void setLimitWeight(String limitWeight) {
        this.limitWeight = limitWeight;
    }
}
