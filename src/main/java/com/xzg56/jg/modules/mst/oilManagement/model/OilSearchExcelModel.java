package com.xzg56.jg.modules.mst.oilManagement.model;

import com.xzg56.core.persistence.BaseModel;
import com.xzg56.utility.excel.annotation.ExcelField;

public class OilSearchExcelModel extends BaseModel{
	
	private static final long serialVersionUID = 7148371302599363897L;
	
	private String seqNo;					//加油记录号
	private String operationTime;			//加油时间
	private String driver;					//司机名
	private String plateNum;				//车牌号
	private String station;					//加油站
	private String tankStorage;				//油箱油量(%)
	private String cardNo;					//油卡号
	private String innerFlag;				//内部/外部加油标志
	private String addLiters;				//加油量（升）
	private String fuelType;				//燃油类型
	private String operationPsn;			//操作人
	private String remarks;					//备注
	private String createPsn;
	private String createTime;	
	private String updatePsn;
	private String updateTime;
	private String fuelFillingZgId;
	private String unitPrice;
	
	@ExcelField(title="单号", align=2, sort=10)
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	@ExcelField(title="加油时间", align=2, sort=20)
	public String getOperationTime() {
		return operationTime;
	}
	public void setOperationTime(String operationTime) {
		this.operationTime = operationTime;
	}
	@ExcelField(title="司机姓名", align=2, sort=50)
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	@ExcelField(title="车牌号", align=2, sort=40)
	public String getPlateNum() {
		return plateNum;
	}
	public void setPlateNum(String plateNum) {
		this.plateNum = plateNum;
	}
	@ExcelField(title="加油站", align=2, sort=100)
	public String getStation() {
		return station;
	}
	public void setStation(String station) {
		this.station = station;
	}
	@ExcelField(title="油箱油量(%)", align=2, sort=90)
	public String getTankStorage() {
		return tankStorage;
	}
	public void setTankStorage(String tankStorage) {
		this.tankStorage = tankStorage;
	}
	@ExcelField(title="油卡号", align=2, sort=60)
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	@ExcelField(title="车场/油卡", align=2, sort=30)
	public String getInnerFlag() {
		return innerFlag;
	}
	public void setInnerFlag(String innerFlag) {
		this.innerFlag = innerFlag;
	}
	@ExcelField(title="加油量（升）", align=2, sort=70)
	public String getAddLiters() {
		return addLiters;
	}
	public void setAddLiters(String addLiters) {
		this.addLiters = addLiters;
	}
	@ExcelField(title="单价（元）", align=2, sort=75)
	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	@ExcelField(title="燃油类型", align=2, sort=80)
	public String getFuelType() {
		return fuelType;
	}
	public void setFuelType(String fuelType) {
		this.fuelType = fuelType;
	}
	@ExcelField(title="加油操作人", align=2, sort=110)
	public String getOperationPsn() {
		return operationPsn;
	}
	public void setOperationPsn(String operationPsn) {
		this.operationPsn = operationPsn;
	}
	@ExcelField(title="备注", align=2, sort=120)
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	@ExcelField(title="创建人", align=2, sort=130)
	public String getCreatePsn() {
		return createPsn;
	}
	public void setCreatePsn(String createPsn) {
		this.createPsn = createPsn;
	}
	@ExcelField(title="创建时间", align=2, sort=140)
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	@ExcelField(title="更新人", align=2, sort=150)
	public String getUpdatePsn() {
		return updatePsn;
	}
	public void setUpdatePsn(String updatePsn) {
		this.updatePsn = updatePsn;
	}
	@ExcelField(title="更新时间", align=2, sort=160)
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getFuelFillingZgId() {
		return fuelFillingZgId;
	}

	public void setFuelFillingZgId(String fuelFillingZgId) {
		this.fuelFillingZgId = fuelFillingZgId;
	}
}
