package com.xzg56.jg.modules.mst.selfTrailer.model;


import com.xzg56.core.persistence.IdEntity;

public class SelfTrailerModel extends IdEntity<SelfTrailerModel> {
	private static final long serialVersionUID = -2669124822079953558L;

	private String plateNum;
	private String gpsPlateNum;
	private String tWheelType;
	private String productionYear;
	private String age;
	private String identityNo;
	private String currentDrvCode;
	private String currentDrvCodeName;
	private String currentCfNum;
	private String curStopCode;
	private String curStopFaddrs;
	private String tankLiters;
	private String eqmGroupCode;
	private String maxLoad;
	private String trailerType;
	private String fuelType;
	private String compy;
	private String createPsn;
	private String createT;
	private String updatePsn;
	private String updateT;
	private String validFlag;
	private String getGpsFlag;
	private String scrapTime;
	private String buyTime;
	private String productModel;
	private String engineNo;
	private String yearInspectDate;
	private String quarterlyInspectDate;
	private String businessInspectDate;
	private String insuranceEndDate;
	private String luqiaoFeeEndDate;
	private String remarks;
	private String zhangzhouFlag;
	private String equipmentMaintenanceAccrue;
	private String equipmentInsuranceAccrue;
	private String ureaAccrue;
	private String equipmentDepreciationAccrue;
	private String controlGroup;
	private String monthlyAverageDrvordNum;
	private String tWheelTypeLabel;
	private String trailerTypeLabel;
	private String fuelTypeLabel;
	private String validFlagLabel;
	private String zhangzhouFlagLabel;
	private String controlGroupLabel;
	private String pageType;
	private String address;

	private String trailerBelongTypeCd;
	private String trailerBelongType;
	private String attachDrvCode;
	private String attachDrvName;
	private String outerDrvCode;
	private String outerDrvName;
	private String relatedDrvCode;// 关系人/车队
	private String liters;//百公里油耗

	public String getPlateNum() {
		return plateNum;
	}

	public void setPlateNum(String plateNum) {
		this.plateNum = plateNum;
	}

	public String getGpsPlateNum() {
		return gpsPlateNum;
	}

	public void setGpsPlateNum(String gpsPlateNum) {
		this.gpsPlateNum = gpsPlateNum;
	}

	public String gettWheelType() {
		return tWheelType;
	}

	public void settWheelType(String tWheelType) {
		this.tWheelType = tWheelType;
	}

	public String getProductionYear() {
		return productionYear;
	}

	public void setProductionYear(String productionYear) {
		this.productionYear = productionYear;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getIdentityNo() {
		return identityNo;
	}

	public void setIdentityNo(String identityNo) {
		this.identityNo = identityNo;
	}

	public String getCurrentDrvCode() {
		return currentDrvCode;
	}

	public void setCurrentDrvCode(String currentDrvCode) {
		this.currentDrvCode = currentDrvCode;
	}

	public String getCurrentDrvCodeName() {
		return currentDrvCodeName;
	}

	public void setCurrentDrvCodeName(String currentDrvCodeName) {
		this.currentDrvCodeName = currentDrvCodeName;
	}

	public String getCurrentCfNum() {
		return currentCfNum;
	}

	public void setCurrentCfNum(String currentCfNum) {
		this.currentCfNum = currentCfNum;
	}

	public String getCurStopCode() {
		return curStopCode;
	}

	public void setCurStopCode(String curStopCode) {
		this.curStopCode = curStopCode;
	}

	public String getCurStopFaddrs() {
		return curStopFaddrs;
	}

	public void setCurStopFaddrs(String curStopFaddrs) {
		this.curStopFaddrs = curStopFaddrs;
	}

	public String getTankLiters() {
		return tankLiters;
	}

	public void setTankLiters(String tankLiters) {
		this.tankLiters = tankLiters;
	}

	public String getEqmGroupCode() {
		return eqmGroupCode;
	}

	public void setEqmGroupCode(String eqmGroupCode) {
		this.eqmGroupCode = eqmGroupCode;
	}

	public String getMaxLoad() {
		return maxLoad;
	}

	public void setMaxLoad(String maxLoad) {
		this.maxLoad = maxLoad;
	}

	public String getTrailerType() {
		return trailerType;
	}

	public void setTrailerType(String trailerType) {
		this.trailerType = trailerType;
	}

	public String getFuelType() {
		return fuelType;
	}

	public void setFuelType(String fuelType) {
		this.fuelType = fuelType;
	}

	public String getCompy() {
		return compy;
	}

	public void setCompy(String compy) {
		this.compy = compy;
	}

	public String getCreatePsn() {
		return createPsn;
	}

	public void setCreatePsn(String createPsn) {
		this.createPsn = createPsn;
	}

	public String getUpdatePsn() {
		return updatePsn;
	}

	public void setUpdatePsn(String updatePsn) {
		this.updatePsn = updatePsn;
	}

	public String getValidFlag() {
		return validFlag;
	}

	public void setValidFlag(String validFlag) {
		this.validFlag = validFlag;
	}

	public String getGetGpsFlag() {
		return getGpsFlag;
	}

	public void setGetGpsFlag(String getGpsFlag) {
		this.getGpsFlag = getGpsFlag;
	}

	public String getScrapTime() {
		return scrapTime;
	}

	public void setScrapTime(String scrapTime) {
		this.scrapTime = scrapTime;
	}

	public String getBuyTime() {
		return buyTime;
	}

	public void setBuyTime(String buyTime) {
		this.buyTime = buyTime;
	}

	public String getProductModel() {
		return productModel;
	}

	public void setProductModel(String productModel) {
		this.productModel = productModel;
	}

	public String getEngineNo() {
		return engineNo;
	}

	public void setEngineNo(String engineNo) {
		this.engineNo = engineNo;
	}

	public String getYearInspectDate() {
		return yearInspectDate;
	}

	public void setYearInspectDate(String yearInspectDate) {
		this.yearInspectDate = yearInspectDate;
	}

	public String getQuarterlyInspectDate() {
		return quarterlyInspectDate;
	}

	public void setQuarterlyInspectDate(String quarterlyInspectDate) {
		this.quarterlyInspectDate = quarterlyInspectDate;
	}

	public String getBusinessInspectDate() {
		return businessInspectDate;
	}

	public void setBusinessInspectDate(String businessInspectDate) {
		this.businessInspectDate = businessInspectDate;
	}

	public String getInsuranceEndDate() {
		return insuranceEndDate;
	}

	public void setInsuranceEndDate(String insuranceEndDate) {
		this.insuranceEndDate = insuranceEndDate;
	}

	public String getLuqiaoFeeEndDate() {
		return luqiaoFeeEndDate;
	}

	public void setLuqiaoFeeEndDate(String luqiaoFeeEndDate) {
		this.luqiaoFeeEndDate = luqiaoFeeEndDate;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getZhangzhouFlag() {
		return zhangzhouFlag;
	}

	public void setZhangzhouFlag(String zhangzhouFlag) {
		this.zhangzhouFlag = zhangzhouFlag;
	}

	public String getEquipmentMaintenanceAccrue() {
		return equipmentMaintenanceAccrue;
	}

	public void setEquipmentMaintenanceAccrue(String equipmentMaintenanceAccrue) {
		this.equipmentMaintenanceAccrue = equipmentMaintenanceAccrue;
	}

	public String getEquipmentInsuranceAccrue() {
		return equipmentInsuranceAccrue;
	}

	public void setEquipmentInsuranceAccrue(String equipmentInsuranceAccrue) {
		this.equipmentInsuranceAccrue = equipmentInsuranceAccrue;
	}

	public String getUreaAccrue() {
		return ureaAccrue;
	}

	public void setUreaAccrue(String ureaAccrue) {
		this.ureaAccrue = ureaAccrue;
	}

	public String getEquipmentDepreciationAccrue() {
		return equipmentDepreciationAccrue;
	}

	public void setEquipmentDepreciationAccrue(String equipmentDepreciationAccrue) {
		this.equipmentDepreciationAccrue = equipmentDepreciationAccrue;
	}

	public String getControlGroup() {
		return controlGroup;
	}

	public void setControlGroup(String controlGroup) {
		this.controlGroup = controlGroup;
	}

	public String getMonthlyAverageDrvordNum() {
		return monthlyAverageDrvordNum;
	}

	public void setMonthlyAverageDrvordNum(String monthlyAverageDrvordNum) {
		this.monthlyAverageDrvordNum = monthlyAverageDrvordNum;
	}

	public String gettWheelTypeLabel() {
		return tWheelTypeLabel;
	}

	public void settWheelTypeLabel(String tWheelTypeLabel) {
		this.tWheelTypeLabel = tWheelTypeLabel;
	}

	public String getTrailerTypeLabel() {
		return trailerTypeLabel;
	}

	public void setTrailerTypeLabel(String trailerTypeLabel) {
		this.trailerTypeLabel = trailerTypeLabel;
	}

	public String getFuelTypeLabel() {
		return fuelTypeLabel;
	}

	public void setFuelTypeLabel(String fuelTypeLabel) {
		this.fuelTypeLabel = fuelTypeLabel;
	}

	public String getValidFlagLabel() {
		return validFlagLabel;
	}

	public void setValidFlagLabel(String validFlagLabel) {
		this.validFlagLabel = validFlagLabel;
	}

	public String getZhangzhouFlagLabel() {
		return zhangzhouFlagLabel;
	}

	public void setZhangzhouFlagLabel(String zhangzhouFlagLabel) {
		this.zhangzhouFlagLabel = zhangzhouFlagLabel;
	}

	public String getControlGroupLabel() {
		return controlGroupLabel;
	}

	public void setControlGroupLabel(String controlGroupLabel) {
		this.controlGroupLabel = controlGroupLabel;
	}

	public String getCreateT() {
		return createT;
	}

	public void setCreateT(String createT) {
		this.createT = createT;
	}

	public String getUpdateT() {
		return updateT;
	}

	public void setUpdateT(String updateT) {
		this.updateT = updateT;
	}

	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTrailerBelongTypeCd() {
		return trailerBelongTypeCd;
	}

	public void setTrailerBelongTypeCd(String trailerBelongTypeCd) {
		this.trailerBelongTypeCd = trailerBelongTypeCd;
	}

	public String getTrailerBelongType() {
		return trailerBelongType;
	}

	public void setTrailerBelongType(String trailerBelongType) {
		this.trailerBelongType = trailerBelongType;
	}

	public String getAttachDrvCode() {
		return attachDrvCode;
	}

	public void setAttachDrvCode(String attachDrvCode) {
		this.attachDrvCode = attachDrvCode;
	}

	public String getAttachDrvName() {
		return attachDrvName;
	}

	public void setAttachDrvName(String attachDrvName) {
		this.attachDrvName = attachDrvName;
	}

	public String getRelatedDrvCode() {
		return relatedDrvCode;
	}

	public void setRelatedDrvCode(String relatedDrvCode) {
		this.relatedDrvCode = relatedDrvCode;
	}

	public String getOuterDrvName() {
		return outerDrvName;
	}

	public void setOuterDrvName(String outerDrvName) {
		this.outerDrvName = outerDrvName;
	}

	public String getOuterDrvCode() {
		return outerDrvCode;
	}

	public void setOuterDrvCode(String outerDrvCode) {
		this.outerDrvCode = outerDrvCode;
	}

	public String getLiters() {
		return liters;
	}

	public void setLiters(String liters) {
		this.liters = liters;
	}
}
