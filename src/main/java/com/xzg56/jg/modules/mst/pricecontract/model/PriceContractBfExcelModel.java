package com.xzg56.jg.modules.mst.pricecontract.model;


import com.xzg56.core.persistence.BaseModel;
import com.xzg56.utility.excel.annotation.ExcelField;

/**
 * Created by wellen on 2019/5/8.
 */

public class PriceContractBfExcelModel extends BaseModel {
    private String priceContractName;
    private String priceContractNo;//价格协议号
    private String chargingTypeName;
    private String chargingType;//计费方式
    private String binsType;//内外贸
    private String ioType;//进出口
    private String fromProvinceCode;//省编码
    private String fromCityCode;//市编码
    private String fromDistrictCode;//区/县编码
    private String fromCountyCode;//乡镇编码
    private String ToProvinceCode;//省编码
    private String ToCityCode;//市编码
    private String ToDistrictCode;//区/县编码
    private String ToCountyCode;//乡镇编码
    private String containerTypeName;//集装箱价格等级类型
    private String containerType;//集装箱价格等级类型
    private String remarks;//备注
    private String rCusBfPrice;//客户核定-应收-单价（元）
    private String rCusBfPriceNoTax;//客户核定-应收-不含税单价（元）
    private String validFlag;//有效标志
    private String roundTripFlag;//双程标志
    private String overweightPrice;//超重费用（元/每吨）
    private String limitWeight;//超重阈值（吨）
    private String fromAdrsName;
    private String toAdrsName;

    @ExcelField(title="协议名称", align=2, sort=1)
    public String getPriceContractName() {
        return priceContractName;
    }

    public void setPriceContractName(String priceContractName) {
        this.priceContractName = priceContractName;
    }

    @ExcelField(title="协议编码", align=2, sort=5)
    public String getPriceContractNo() {
        return priceContractNo;
    }

    public void setPriceContractNo(String priceContractNo) {
        this.priceContractNo = priceContractNo;
    }

    @ExcelField(title="计费模式", align=2, sort=10)
    public String getChargingTypeName() {
        return chargingTypeName;
    }

    public void setChargingTypeName(String chargingTypeName) {
        this.chargingTypeName = chargingTypeName;
    }

    @ExcelField(title="计费模式编码", align=2, sort=15)
    public String getChargingType() {
        return chargingType;
    }

    public void setChargingType(String chargingType) {
        this.chargingType = chargingType;
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

    @ExcelField(title="省", align=2, sort=50)
    public String getFromProvinceCode() {
        return fromProvinceCode;
    }

    public void setFromProvinceCode(String fromProvinceCode) {
        this.fromProvinceCode = fromProvinceCode;
    }

    @ExcelField(title="市", align=2, sort=60)
    public String getFromCityCode() {
        return fromCityCode;
    }

    public void setFromCityCode(String fromCityCode) {
        this.fromCityCode = fromCityCode;
    }

    @ExcelField(title="区/县", align=2, sort=70)
    public String getFromDistrictCode() {
        return fromDistrictCode;
    }

    public void setFromDistrictCode(String fromDistrictCode) {
        this.fromDistrictCode = fromDistrictCode;
    }

    @ExcelField(title="乡/镇", align=2, sort=80)
    public String getFromCountyCode() {
        return fromCountyCode;
    }

    public void setFromCountyCode(String fromCountyCode) {
        this.fromCountyCode = fromCountyCode;
    }

    @ExcelField(title="省", align=2, sort=90)
    public String getToProvinceCode() {
        return ToProvinceCode;
    }

    public void setToProvinceCode(String toProvinceCode) {
        ToProvinceCode = toProvinceCode;
    }

    @ExcelField(title="市", align=2, sort=100)
    public String getToCityCode() {
        return ToCityCode;
    }

    public void setToCityCode(String toCityCode) {
        ToCityCode = toCityCode;
    }

    @ExcelField(title="区/县", align=2, sort=110)
    public String getToDistrictCode() {
        return ToDistrictCode;
    }

    public void setToDistrictCode(String toDistrictCode) {
        ToDistrictCode = toDistrictCode;
    }

    @ExcelField(title="乡/镇", align=2, sort=120)
    public String getToCountyCode() {
        return ToCountyCode;
    }

    public void setToCountyCode(String toCountyCode) {
        ToCountyCode = toCountyCode;
    }

    @ExcelField(title="集装箱等级", align=2, sort=20)
    public String getContainerTypeName() {
        return containerTypeName;
    }

    public void setContainerTypeName(String containerTypeName) {
        this.containerTypeName = containerTypeName;
    }

    @ExcelField(title="集装箱等级编码", align=2, sort=25)
    public String getContainerType() {
        return containerType;
    }

    public void setContainerType(String containerType) {
        this.containerType = containerType;
    }

    @ExcelField(title="备注", align=2, sort=160)
    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @ExcelField(title="单价（元）", align=2, sort=30)
    public String getrCusBfPrice() {
        return rCusBfPrice;
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

    @ExcelField(title="双程标志", align=2, sort=130)
    public String getRoundTripFlag() {
        return roundTripFlag;
    }

    public void setRoundTripFlag(String roundTripFlag) {
        this.roundTripFlag = roundTripFlag;
    }

    @ExcelField(title="超重费用（元/每吨）", align=2, sort=140)
    public String getOverweightPrice() {
        return overweightPrice;
    }

    public void setOverweightPrice(String overweightPrice) {
        this.overweightPrice = overweightPrice;
    }

    @ExcelField(title="超重阈值（吨）", align=2, sort=150)
    public String getLimitWeight() {
        return limitWeight;
    }

    public void setLimitWeight(String limitWeight) {
        this.limitWeight = limitWeight;
    }

    @ExcelField(title="起始地址", align=2, sort=40)
    public String getFromAdrsName() {
        return fromAdrsName;
    }

    public void setFromAdrsName(String fromAdrsName) {
        this.fromAdrsName = fromAdrsName;
    }

    @ExcelField(title="到达地址", align=2, sort=85)
    public String getToAdrsName() {
        return toAdrsName;
    }

    public void setToAdrsName(String toAdrsName) {
        this.toAdrsName = toAdrsName;
    }
}
