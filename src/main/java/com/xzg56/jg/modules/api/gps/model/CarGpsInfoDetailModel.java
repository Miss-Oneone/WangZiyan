package com.xzg56.jg.modules.api.gps.model;


import com.xzg56.core.persistence.BaseModel;

import java.util.Date;

public class CarGpsInfoDetailModel extends BaseModel {

	private String carNo;
	private String plateNum;
//	private String gpsPlateNum;
	private String mileSum;
	private String beginTime;
	private String endTime;
	private String divMileSum;
	private String createBy;
	private Date createTime;
	private String updateBy;
	private Date updateTime;
	private String msg;
	private String resultFlag;
	private String differenceMileSum;

	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	public String getPlateNum() {
		return plateNum;
	}

	public void setPlateNum(String plateNum) {
		this.plateNum = plateNum;
	}

	public String getMileSum() {
		return mileSum;
	}

	public void setMileSum(String mileSum) {
		this.mileSum = mileSum;
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

	public String getDivMileSum() {
		return divMileSum;
	}

	public void setDivMileSum(String divMileSum) {
		this.divMileSum = divMileSum;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getResultFlag() {
		return resultFlag;
	}

	public void setResultFlag(String resultFlag) {
		this.resultFlag = resultFlag;
	}

	public String getDifferenceMileSum() {
		return differenceMileSum;
	}

	public void setDifferenceMileSum(String differenceMileSum) {
		this.differenceMileSum = differenceMileSum;
	}

}