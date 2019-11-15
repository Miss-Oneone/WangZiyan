package com.xzg56.jg.modules.mst.oilManagement.model;


import com.xzg56.core.persistence.BaseModel;

public class OilShareFormModel extends BaseModel {

	/**
	 * 装载加油分摊信息form的model
	 */
	private static final long serialVersionUID = 1L;
	
	private String driver;					//司机名
	private String driverCode;				//司机编码
	private String plateNum;				//车牌号
	private double tankLiters;				//油箱容量（升）
	private String lastAddTime;				//上次加油时间
	private String thisAddTime;				//本次加油时间
	private double lastTankStorage;			//上次油箱油量（%）
	private double thisTankStorage;			//本次加油后油箱油量（%）
	private double thisAddLiters;			//本次加油量（升）
	private double thisStorageOil;			//本次加油后存油量（升）
	private double lastStorageOil;			//上次加油后存油量（升）
	private double allBugtAdjGas;			//预算油耗合计（升）
	private double factOilWear;				//系统计算实际油耗（升）
	private String fuelType;				//燃油类型
	
	public double getLastStorageOil() {
		return lastStorageOil;
	}
	public void setLastStorageOil(double lastStorageOil) {
		this.lastStorageOil = lastStorageOil;
	}
	public String getFuelType() {
		return fuelType;
	}
	public void setFuelType(String fuelType) {
		this.fuelType = fuelType;
	}
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getDriverCode() {
		return driverCode;
	}
	public void setDriverCode(String driverCode) {
		this.driverCode = driverCode;
	}
	public String getPlateNum() {
		return plateNum;
	}
	public void setPlateNum(String plateNum) {
		this.plateNum = plateNum;
	}
	public double getTankLiters() {
		return tankLiters;
	}
	public void setTankLiters(double tankLiters) {
		this.tankLiters = tankLiters;
	}
	public String getLastAddTime() {
		return lastAddTime;
	}
	public void setLastAddTime(String lastAddTime) {
		this.lastAddTime = lastAddTime;
	}
	public String getThisAddTime() {
		return thisAddTime;
	}
	public void setThisAddTime(String thisAddTime) {
		this.thisAddTime = thisAddTime;
	}
	public double getLastTankStorage() {
		return lastTankStorage;
	}
	public void setLastTankStorage(double lastTankStorage) {
		this.lastTankStorage = lastTankStorage;
	}
	public double getThisTankStorage() {
		return thisTankStorage;
	}
	public void setThisTankStorage(double thisTankStorage) {
		this.thisTankStorage = thisTankStorage;
	}
	public double getThisAddLiters() {
		return thisAddLiters;
	}
	public void setThisAddLiters(double thisAddLiters) {
		this.thisAddLiters = thisAddLiters;
	}
	public double getThisStorageOil() {
		return thisStorageOil;
	}
	public void setThisStorageOil(double thisStorageOil) {
		this.thisStorageOil = thisStorageOil;
	}
	public double getAllBugtAdjGas() {
		return allBugtAdjGas;
	}
	public void setAllBugtAdjGas(double allBugtAdjGas) {
		this.allBugtAdjGas = allBugtAdjGas;
	}
	public double getFactOilWear() {
		return factOilWear;
	}
	public void setFactOilWear(double factOilWear) {
		this.factOilWear = factOilWear;
	}
	
}