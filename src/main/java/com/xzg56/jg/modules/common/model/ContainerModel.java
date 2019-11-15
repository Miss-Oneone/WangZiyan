package com.xzg56.jg.modules.common.model;


import com.xzg56.core.persistence.IdEntity;

/**
 * Created by cjx on 2019/03/22
 */

public class ContainerModel extends IdEntity<ContainerModel> {

    private String orderNo;//系统单号
    private String cusCode;//客户
    private String departureDate;//发车日期
    private String goodsCode;//货物
    private String routerType;//路线类型
    private String blNo;//提单号
    private String contnNo;//柜号
    private String sealNo;//封签
    private String plateNum;//车牌号
    private String frameNo;//车架号编码
    private String collectionOrderYes;//是收单
    private String collectionOrderNo;//否收单
    private String count;//数量
    private String price;//价格
    private String remark;//备注
    private String driverCode;//司机
    private String chargingType;//计费模式
    private String acceptOrderFlag;//是否收单
    private String status;//状态
    private String userId;

    private String orderNoF;
    private String beginTime;//开始时间
    private String endTime;//结束时间

    private String documentNo;//单据号
    private String bfLevelCode;//柜型
    private String batchNo;//批号
    private String transportType;//运输方式
    private String goodsCodeIn;//对内货物
    private String goodsCodeOut;//对外货物
    private String startArr;//起运地
    private String distination;//到达地
    private String fee;//费用
    private String frameNum;//车架号

    private String orderDate;//接单日期
    private String orderDateBegin;//接单日期
    private String orderDateEnd;//接单日期

    private String unScheduling;//未排期
    private String scheduling;//已排期

    private String bgcolor;//颜色

    private String tripFlagUp;//行程标志（上行）
    private String tripFlagDown;//行程标志（下行）

    private String tripFlag;//行程标志

    private String tripFlagNone;//无行程标志

    private String ioTypeFlag;//进口标志

    private String ioType;//业务类型
    private String changeBoxTime;//还箱时间
    private String crossBoxTime;//截箱时间

    private String changeBoxBeginTime;//还箱开始时间
    private String changeBoxEndTime;//还箱结束时间
    private String crossBoxBeginTime;//截箱开始时间
    private String crossBoxEndTime;//截箱结束时间
    private String overdue;//超期
    private String wagesFlag;//工资未录
    private String freightFlag;//运费未录

    private String relatedDrvCode;
    private String relatedDrvName;

    private String provinceCode;
    private String cityCode;
    private String districtCode;
    private String countyCode;
    private String provinceName;
    private String cityName;
    private String districtName;
    private String countyName;
    private String contactPerson;
    private String contactPhone;
    private String fromProvinceCode;
    private String fromCityCode;
    private String fromDistrictCode;
    private String fromCountyCode;
    private String fromProvinceName;
    private String fromCityName;
    private String fromDistrictName;
    private String fromCountyName;
    private String fromZxAdrs;
    private String toProvinceCode;
    private String toCityCode;
    private String toDistrictCode;
    private String toCountyCode;
    private String toProvinceName;
    private String toCityName;
    private String toDistrictName;
    private String toCountyName;
    private String toZxAdrs;
    private String priceContract;
    private String contaBfId;
    private double rCusBfPrice;
    private double weight;
    private double volume;
    private double limitWeight;
    private double overweight;
    private double overweightPrice;
    private String fromAddressFull;
    private String toAddressFull;
    private String fromContactPerson;
    private String fromContactPhone;
    private String toContactPerson;
    private String toContactPhone;
    private double overweightPriceTip;
    private double unitPriceTip;
    private double limitWeightTip;
    private String roundTripFlag = "N";
    private String addressFull;
    private String adjKmStr;
    private String fuelPriceStr;
    private String liters;
    private String trailerBelongType;
    private String trailerTransportType;
    private String adjKm;
    private String stdDrvSalPrice;

    private String contnOwnerId;
    private String contnType;
    private String contnOwnerName;
    private String specialContnType;
    private String specialContnTypeName;
    private Integer costRouteId;

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode;
    }

    public String getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(String departureDate) {
        this.departureDate = departureDate;
    }

    public String getGoodsCode() {
        return goodsCode;
    }

    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
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

    public String getSealNo() {
        return sealNo;
    }

    public void setSealNo(String sealNo) {
        this.sealNo = sealNo;
    }

    public String getPlateNum() {
        return plateNum;
    }

    public void setPlateNum(String plateNum) {
        this.plateNum = plateNum;
    }

    public String getFrameNo() {
        return frameNo;
    }

    public void setFrameNo(String frameNo) {
        this.frameNo = frameNo;
    }

    public String getCollectionOrderYes() {
        return collectionOrderYes;
    }

    public void setCollectionOrderYes(String collectionOrderYes) {
        this.collectionOrderYes = collectionOrderYes;
    }

    public String getCollectionOrderNo() {
        return collectionOrderNo;
    }

    public void setCollectionOrderNo(String collectionOrderNo) {
        this.collectionOrderNo = collectionOrderNo;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getRouterType() {
        return routerType;
    }

    public void setRouterType(String routerType) {
        this.routerType = routerType;
    }

    public String getDriverCode() {
        return driverCode;
    }

    public void setDriverCode(String driverCode) {
        this.driverCode = driverCode;
    }

    public String getChargingType() {
        return chargingType;
    }

    public void setChargingType(String chargingType) {
        this.chargingType = chargingType;
    }

    public String getAcceptOrderFlag() {
        return acceptOrderFlag;
    }

    public void setAcceptOrderFlag(String acceptOrderFlag) {
        this.acceptOrderFlag = acceptOrderFlag;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    public String getOrderNoF() {
        return orderNoF;
    }

    public void setOrderNoF(String orderNoF) {
        this.orderNoF = orderNoF;
    }

    public String getDocumentNo() {
        return documentNo;
    }

    public void setDocumentNo(String documentNo) {
        this.documentNo = documentNo;
    }

    public String getBfLevelCode() {
        return bfLevelCode;
    }

    public void setBfLevelCode(String bfLevelCode) {
        this.bfLevelCode = bfLevelCode;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public String getTransportType() {
        return transportType;
    }

    public void setTransportType(String transportType) {
        this.transportType = transportType;
    }

    public String getGoodsCodeIn() {
        return goodsCodeIn;
    }

    public void setGoodsCodeIn(String goodsCodeIn) {
        this.goodsCodeIn = goodsCodeIn;
    }

    public String getGoodsCodeOut() {
        return goodsCodeOut;
    }

    public void setGoodsCodeOut(String goodsCodeOut) {
        this.goodsCodeOut = goodsCodeOut;
    }

    public String getStartArr() {
        return startArr;
    }

    public void setStartArr(String startArr) {
        this.startArr = startArr;
    }

    public String getDistination() {
        return distination;
    }

    public void setDistination(String distination) {
        this.distination = distination;
    }

    public String getFee() {
        return fee;
    }

    public void setFee(String fee) {
        this.fee = fee;
    }

    public String getFrameNum() {
        return frameNum;
    }

    public void setFrameNum(String frameNum) {
        this.frameNum = frameNum;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderDateBegin() {
        return orderDateBegin;
    }

    public void setOrderDateBegin(String orderDateBegin) {
        this.orderDateBegin = orderDateBegin;
    }

    public String getOrderDateEnd() {
        return orderDateEnd;
    }

    public void setOrderDateEnd(String orderDateEnd) {
        this.orderDateEnd = orderDateEnd;
    }

    public String getUnScheduling() {
        return unScheduling;
    }

    public void setUnScheduling(String unScheduling) {
        this.unScheduling = unScheduling;
    }

    public String getScheduling() {
        return scheduling;
    }

    public void setScheduling(String scheduling) {
        this.scheduling = scheduling;
    }

    public String getBgcolor() {
        return bgcolor;
    }

    public void setBgcolor(String bgcolor) {
        this.bgcolor = bgcolor;
    }

    public String getTripFlagUp() {
        return tripFlagUp;
    }

    public void setTripFlagUp(String tripFlagUp) {
        this.tripFlagUp = tripFlagUp;
    }

    public String getTripFlagDown() {
        return tripFlagDown;
    }

    public void setTripFlagDown(String tripFlagDown) {
        this.tripFlagDown = tripFlagDown;
    }

    public String getTripFlag() {
        return tripFlag;
    }

    public void setTripFlag(String tripFlag) {
        this.tripFlag = tripFlag;
    }

    public String getTripFlagNone() {
        return tripFlagNone;
    }

    public void setTripFlagNone(String tripFlagNone) {
        this.tripFlagNone = tripFlagNone;
    }

    public String getIoTypeFlag() {
        return ioTypeFlag;
    }

    public void setIoTypeFlag(String ioTypeFlag) {
        this.ioTypeFlag = ioTypeFlag;
    }

    public String getIoType() {
        return ioType;
    }

    public void setIoType(String ioType) {
        this.ioType = ioType;
    }

    public String getChangeBoxTime() {
        return changeBoxTime;
    }

    public void setChangeBoxTime(String changeBoxTime) {
        this.changeBoxTime = changeBoxTime;
    }

    public String getChangeBoxBeginTime() {
        return changeBoxBeginTime;
    }

    public void setChangeBoxBeginTime(String changeBoxBeginTime) {
        this.changeBoxBeginTime = changeBoxBeginTime;
    }

    public String getChangeBoxEndTime() {
        return changeBoxEndTime;
    }

    public void setChangeBoxEndTime(String changeBoxEndTime) {
        this.changeBoxEndTime = changeBoxEndTime;
    }

    public String getCrossBoxTime() {
        return crossBoxTime;
    }

    public void setCrossBoxTime(String crossBoxTime) {
        this.crossBoxTime = crossBoxTime;
    }

    public String getCrossBoxBeginTime() {
        return crossBoxBeginTime;
    }

    public void setCrossBoxBeginTime(String crossBoxBeginTime) {
        this.crossBoxBeginTime = crossBoxBeginTime;
    }

    public String getCrossBoxEndTime() {
        return crossBoxEndTime;
    }

    public void setCrossBoxEndTime(String crossBoxEndTime) {
        this.crossBoxEndTime = crossBoxEndTime;
    }

    public String getOverdue() {
        return overdue;
    }

    public void setOverdue(String overdue) {
        this.overdue = overdue;
    }

    public String getWagesFlag() {
        return wagesFlag;
    }

    public void setWagesFlag(String wagesFlag) {
        this.wagesFlag = wagesFlag;
    }

    public String getFreightFlag() {
        return freightFlag;
    }

    public void setFreightFlag(String freightFlag) {
        this.freightFlag = freightFlag;
    }

    public String getRelatedDrvCode() {
        return relatedDrvCode;
    }

    public void setRelatedDrvCode(String relatedDrvCode) {
        this.relatedDrvCode = relatedDrvCode;
    }

    public String getRelatedDrvName() {
        return relatedDrvName;
    }

    public void setRelatedDrvName(String relatedDrvName) {
        this.relatedDrvName = relatedDrvName;
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

    public String getFromZxAdrs() {
        return fromZxAdrs;
    }

    public void setFromZxAdrs(String fromZxAdrs) {
        this.fromZxAdrs = fromZxAdrs;
    }

    public String getToProvinceCode() {
        return toProvinceCode;
    }

    public void setToProvinceCode(String toProvinceCode) {
        this.toProvinceCode = toProvinceCode;
    }

    public String getToCityCode() {
        return toCityCode;
    }

    public void setToCityCode(String toCityCode) {
        this.toCityCode = toCityCode;
    }

    public String getToDistrictCode() {
        return toDistrictCode;
    }

    public void setToDistrictCode(String toDistrictCode) {
        this.toDistrictCode = toDistrictCode;
    }

    public String getToCountyCode() {
        return toCountyCode;
    }

    public void setToCountyCode(String toCountyCode) {
        this.toCountyCode = toCountyCode;
    }

    public String getToZxAdrs() {
        return toZxAdrs;
    }

    public void setToZxAdrs(String toZxAdrs) {
        this.toZxAdrs = toZxAdrs;
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getDistrictCode() {
        return districtCode;
    }

    public void setDistrictCode(String districtCode) {
        this.districtCode = districtCode;
    }

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getPriceContract() {
        return priceContract;
    }

    public void setPriceContract(String priceContract) {
        this.priceContract = priceContract;
    }

    public String getContaBfId() {
        return contaBfId;
    }

    public void setContaBfId(String contaBfId) {
        this.contaBfId = contaBfId;
    }

    public double getrCusBfPrice() {
        return rCusBfPrice;
    }

    public void setrCusBfPrice(double rCusBfPrice) {
        this.rCusBfPrice = rCusBfPrice;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getVolume() {
        return volume;
    }

    public void setVolume(double volume) {
        this.volume = volume;
    }

    public double getLimitWeight() {
        return limitWeight;
    }

    public void setLimitWeight(double limitWeight) {
        this.limitWeight = limitWeight;
    }

    public double getOverweight() {
        return overweight;
    }

    public void setOverweight(double overweight) {
        this.overweight = overweight;
    }

    public double getOverweightPrice() {
        return overweightPrice;
    }

    public void setOverweightPrice(double overweightPrice) {
        this.overweightPrice = overweightPrice;
    }

    public String getFromAddressFull() {
        return fromAddressFull;
    }

    public void setFromAddressFull(String fromAddressFull) {
        this.fromAddressFull = fromAddressFull;
    }

    public String getToAddressFull() {
        return toAddressFull;
    }

    public void setToAddressFull(String toAddressFull) {
        this.toAddressFull = toAddressFull;
    }

    public String getFromContactPerson() {
        return fromContactPerson;
    }

    public void setFromContactPerson(String fromContactPerson) {
        this.fromContactPerson = fromContactPerson;
    }

    public String getFromContactPhone() {
        return fromContactPhone;
    }

    public void setFromContactPhone(String fromContactPhone) {
        this.fromContactPhone = fromContactPhone;
    }

    public String getToContactPerson() {
        return toContactPerson;
    }

    public void setToContactPerson(String toContactPerson) {
        this.toContactPerson = toContactPerson;
    }

    public String getToContactPhone() {
        return toContactPhone;
    }

    public void setToContactPhone(String toContactPhone) {
        this.toContactPhone = toContactPhone;
    }

    public double getOverweightPriceTip() {
        return overweightPriceTip;
    }

    public void setOverweightPriceTip(double overweightPriceTip) {
        this.overweightPriceTip = overweightPriceTip;
    }

    public double getUnitPriceTip() {
        return unitPriceTip;
    }

    public void setUnitPriceTip(double unitPriceTip) {
        this.unitPriceTip = unitPriceTip;
    }

    public double getLimitWeightTip() {
        return limitWeightTip;
    }

    public void setLimitWeightTip(double limitWeightTip) {
        this.limitWeightTip = limitWeightTip;
    }

    public String getRoundTripFlag() {
        return roundTripFlag;
    }

    public void setRoundTripFlag(String roundTripFlag) {
        this.roundTripFlag = roundTripFlag;
    }

    public String getAddressFull() {
        return addressFull;
    }

    public void setAddressFull(String addressFull) {
        this.addressFull = addressFull;
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

    public String getAdjKmStr() {
        return adjKmStr;
    }

    public void setAdjKmStr(String adjKmStr) {
        this.adjKmStr = adjKmStr;
    }

    public String getFuelPriceStr() {
        return fuelPriceStr;
    }

    public void setFuelPriceStr(String fuelPriceStr) {
        this.fuelPriceStr = fuelPriceStr;
    }

    public String getLiters() {
        return liters;
    }

    public void setLiters(String liters) {
        this.liters = liters;
    }

    public String getTrailerBelongType() {
        return trailerBelongType;
    }

    public void setTrailerBelongType(String trailerBelongType) {
        this.trailerBelongType = trailerBelongType;
    }

    public String getTrailerTransportType() {
        return trailerTransportType;
    }

    public void setTrailerTransportType(String trailerTransportType) {
        this.trailerTransportType = trailerTransportType;
    }

    public String getAdjKm() {
        return adjKm;
    }

    public void setAdjKm(String adjKm) {
        this.adjKm = adjKm;
    }

    public String getStdDrvSalPrice() {
        return stdDrvSalPrice;
    }

    public void setStdDrvSalPrice(String stdDrvSalPrice) {
        this.stdDrvSalPrice = stdDrvSalPrice;
    }

    public String getContnOwnerId() {
        return contnOwnerId;
    }

    public void setContnOwnerId(String contnOwnerId) {
        this.contnOwnerId = contnOwnerId;
    }

    public String getContnType() {
        return contnType;
    }

    public void setContnType(String contnType) {
        this.contnType = contnType;
    }

    public String getContnOwnerName() {
        return contnOwnerName;
    }

    public void setContnOwnerName(String contnOwnerName) {
        this.contnOwnerName = contnOwnerName;
    }

    public String getSpecialContnType() {
        return specialContnType;
    }

    public void setSpecialContnType(String specialContnType) {
        this.specialContnType = specialContnType;
    }

    public String getSpecialContnTypeName() {
        return specialContnTypeName;
    }

    public void setSpecialContnTypeName(String specialContnTypeName) {
        this.specialContnTypeName = specialContnTypeName;
    }

    public Integer getCostRouteId() {
        return costRouteId;
    }

    public void setCostRouteId(Integer costRouteId) {
        this.costRouteId = costRouteId;
    }
}
