package com.xzg56.jg.modules.mst.pricecontract.model;


import com.xzg56.jg.modules.common.persistence.entity.PriceContractBf;

/**
 * Created by wjn on 2017/12/20
 */

public class PriceContractChangeModel extends PriceContractBf {
    private String provinceName;//省名称
    private String cityName;//市名称
    private String districtName;//区/县名称
    private String countyName;//乡镇名称
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

    private String beginTime;//开始时间
    private String endTime;//结束时间
    private String num;// 个数
    private String validFlag;// 有效标志
    private String changeType;//变动类型

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

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public String getCountyName() {
        return countyName;
    }

    public void setCountyName(String countyName) {
        this.countyName = countyName;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getValidFlag() {
        return validFlag;
    }

    public void setValidFlag(String validFlag) {
        this.validFlag = validFlag;
    }

    public String getChangeType() {
        return changeType;
    }

    public void setChangeType(String changeType) {
        this.changeType = changeType;
    }
}
