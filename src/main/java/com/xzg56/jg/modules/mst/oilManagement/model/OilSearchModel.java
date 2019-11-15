package com.xzg56.jg.modules.mst.oilManagement.model;


import com.xzg56.core.persistence.BaseModel;

public class OilSearchModel extends BaseModel {

	
	
	/**
	 * 装载查询加油信息的model
	 */
	private static final long serialVersionUID = 1L;
	private String seqNo;					//加油记录号
	private String operationTime;			//加油时间
	private String operationTimeFrom;		//加油时间始
	private String operationTimeTo;			//加油时间末
	private String driver;					//司机名
	private String driverCode;				//司机编码
	private String plateNum;				//车牌号
	private String station;					//加油站
	private double tankLiters;				//油箱容量（升）
	private double tankStorage;				//油箱油量(%)
	private String cardNo;					//油卡号
	private String blNo;					//提单号
	private String contnNo;					//集装箱号
	private String innerFlag;				//内部/外部加油标志
	private double thePrice;				//当天油价
	private String addLiters;				//加油量（升）
	private double storageOil;				//本次加油后司机存油量（升）
	private String fuelType;				//燃油类型
	private String operationPsn;			//操作人
	private String remarks;					//备注
	private double factOilWear;				//本次实际油耗量（升）
	private String selectValue;
	private String own;						//车场checkbox
	private String out;						//油卡checkbox
	private String fuelFillingZgId;
	private String fuelFillingJgId;
	private boolean autoFlag = false;
	private double unitPrice;
	private double amount;

	public double getFactOilWear() {
		return factOilWear;
	}
	public void setFactOilWear(double factOilWear) {
		this.factOilWear = factOilWear;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public double getStorageOil() {
		return storageOil;
	}
	public void setStorageOil(double storageOil) {
		this.storageOil = storageOil;
	}
	public double getTankLiters() {
		return tankLiters;
	}
	public void setTankLiters(double tankLiters) {
		this.tankLiters = tankLiters;
	}
	public String getDriverCode() {
		return driverCode;
	}
	public void setDriverCode(String driverCode) {
		this.driverCode = driverCode;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public double getTankStorage() {
		return tankStorage;
	}
	public void setTankStorage(double tankStorage) {
		this.tankStorage = tankStorage;
	}
	public String getOperationTime() {
		return operationTime;
	}
	public void setOperationTime(String operationTime) {
		this.operationTime = operationTime;
	}
	public String getOperationTimeFrom() {
		return operationTimeFrom;
	}
	public void setOperationTimeFrom(String operationTimeFrom) {
		this.operationTimeFrom = operationTimeFrom;
	}
	public String getOperationTimeTo() {
		return operationTimeTo;
	}
	public void setOperationTimeTo(String operationTimeTo) {
		this.operationTimeTo = operationTimeTo;
	}
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getPlateNum() {
		return plateNum;
	}
	public void setPlateNum(String plateNum) {
		this.plateNum = plateNum;
	}
	public String getStation() {
		return station;
	}
	public void setStation(String station) {
		this.station = station;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
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
	public String getInnerFlag() {
		return innerFlag;
	}
	public void setInnerFlag(String innerFlag) {
		this.innerFlag = innerFlag;
	}
	public double getThePrice() {
		return thePrice;
	}
	public void setThePrice(double thePrice) {
		this.thePrice = thePrice;
	}
	public String getAddLiters() {
		return addLiters;
	}
	public void setAddLiters(String addLiters) {
		this.addLiters = addLiters;
	}
	public String getFuelType() {
		return fuelType;
	}
	public void setFuelType(String fuelType) {
		this.fuelType = fuelType;
	}
	public String getOperationPsn() {
		return operationPsn;
	}
	public void setOperationPsn(String operationPsn) {
		this.operationPsn = operationPsn;
	}
	public String getSelectValue() {
		return selectValue;
	}
	public void setSelectValue(String selectValue) {
		this.selectValue = selectValue;
	}
	public String getOwn() {
		return own;
	}
	public void setOwn(String own) {
		this.own = own;
	}
	public String getOut() {
		return out;
	}
	public void setOut(String out) {
		this.out = out;
	}

	public String getFuelFillingZgId() {
		return fuelFillingZgId;
	}

	public void setFuelFillingZgId(String fuelFillingZgId) {
		this.fuelFillingZgId = fuelFillingZgId;
	}

	public String getFuelFillingJgId() {
		return fuelFillingJgId;
	}

	public void setFuelFillingJgId(String fuelFillingJgId) {
		this.fuelFillingJgId = fuelFillingJgId;
	}

	public boolean getAutoFlag() {
		return autoFlag;
	}

	public void setAutoFlag(boolean autoFlag) {
		this.autoFlag = autoFlag;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}
}