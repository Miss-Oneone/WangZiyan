package com.xzg56.jg.modules.mst.pricecontract.model;


import com.xzg56.jg.modules.common.persistence.entity.PriceContractBf;

/**
 * Created by wjn on 2017/12/20
 */

public class PriceContractBfModel extends PriceContractBf {
    private String fromProvinceName;//省名称
    private String fromCityName;//市名称
    private String fromDistrictName;//区/县名称
    private String fromCountyName;//乡镇名称
    private String toProvinceName;//省名称
    private String toCityName;//市名称
    private String toDistrictName;//区/县名称
    private String toCountyName;//乡镇名称
    private String containerName;//集装箱等级
    private String priceContractName;
    private String createTimeFmt;
    private String updateTimeFmt;
    private String goodsType;
    private String goodsWeight;
    private String goodsName;
    private String effectiveStatusName;
    private String binsName;
    private String ioName;
    private String binsType;
    private String ioType;
    private String chargingType;
    private String pageType;
    private String effectiveStatus;
    private String value;
    private String text;
    private String ygbCustomer;

    public String getBinsName() {
        return binsName;
    }

    public void setBinsName(String binsName) {
        this.binsName = binsName;
    }

    public String getIoName() {
        return ioName;
    }

    public void setIoName(String ioName) {
        this.ioName = ioName;
    }

    public String getEffectiveStatusName() {
        return effectiveStatusName;
    }

    public void setEffectiveStatusName(String effectiveStatusName) {
        this.effectiveStatusName = effectiveStatusName;
    }

    public String getEffectiveStatus() {
        return effectiveStatus;
    }

    public void setEffectiveStatus(String effectiveStatus) {
        this.effectiveStatus = effectiveStatus;
    }

    public String getGoodsWeight() {
        return goodsWeight;
    }

    public void setGoodsWeight(String goodsWeight) {
        this.goodsWeight = goodsWeight;
    }

    public String getPageType() {
        return pageType;
    }

    public void setPageType(String pageType) {
        this.pageType = pageType;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(String goodsType) {
        this.goodsType = goodsType;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getChargingType() {
        return chargingType;
    }

    public void setChargingType(String chargingType) {
        this.chargingType = chargingType;
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

    public String getPriceContractName() {
        return priceContractName;
    }

    public void setPriceContractName(String priceContractName) {
        this.priceContractName = priceContractName;
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

    public String getContainerName() {
        return containerName;
    }

    public void setContainerName(String containerName) {
        this.containerName = containerName;
    }

    public String getFromProvinceName() {
        return fromProvinceName;
    }

    public void setFromProvinceName(String fromProvinceName) {
        this.fromProvinceName = fromProvinceName;
    }

    public String getFromCityName() {
        return fromCityName;
    }

    public void setFromCityName(String fromCityName) {
        this.fromCityName = fromCityName;
    }

    public String getFromDistrictName() {
        return fromDistrictName;
    }

    public void setFromDistrictName(String fromDistrictName) {
        this.fromDistrictName = fromDistrictName;
    }

    public String getFromCountyName() {
        return fromCountyName;
    }

    public void setFromCountyName(String fromCountyName) {
        this.fromCountyName = fromCountyName;
    }

    public String getToProvinceName() {
        return toProvinceName;
    }

    public void setToProvinceName(String toProvinceName) {
        this.toProvinceName = toProvinceName;
    }

    public String getToCityName() {
        return toCityName;
    }

    public void setToCityName(String toCityName) {
        this.toCityName = toCityName;
    }

    public String getToDistrictName() {
        return toDistrictName;
    }

    public void setToDistrictName(String toDistrictName) {
        this.toDistrictName = toDistrictName;
    }

    public String getToCountyName() {
        return toCountyName;
    }

    public void setToCountyName(String toCountyName) {
        this.toCountyName = toCountyName;
    }

    public String getYgbCustomer() {
        return ygbCustomer;
    }

    public void setYgbCustomer(String ygbCustomer) {
        this.ygbCustomer = ygbCustomer;
    }
}
