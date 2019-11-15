package com.xzg56.jg.modules.api.gps.model;


import com.xzg56.core.persistence.BaseModel;

import java.util.Date;

public class CarGpsInfoModel extends BaseModel {

	private static final long serialVersionUID = 8862115611629209032L;
	private String status;
	private String timeStamp;
	private String Summary;
	private CarGpsInfoSubModel carList;
//	private List<CarGpsInfoDetailModel> carList;
	private String createBy;
	private Date createTime;
	private String updateBy;
	private Date updateTime;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	public String getSummary() {
		return Summary;
	}

	public void setSummary(String summary) {
		Summary = summary;
	}

	public CarGpsInfoSubModel getCarList() {
		return carList;
	}

	public void setCarList(CarGpsInfoSubModel carList) {
		this.carList = carList;
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
}