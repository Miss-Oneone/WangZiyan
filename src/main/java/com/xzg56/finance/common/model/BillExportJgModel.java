package com.xzg56.finance.common.model;

import com.xzg56.core.persistence.IdEntity;

public class BillExportJgModel extends IdEntity<BillExportModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1562916975865675181L;
	
	private String rpFlag; //应收应付 1 2
	private String directFlag; //直接间接 	1,2
	private String feeStatus; //费用状态 
	private String reconFlag; //对账状态-不需要
	private String blNo;
	private String contnNo;
	private String piCode;
	private String relatedCompy;
	private String occurDateFrom;
	private String occurDateTo;
	private String createDateFrom;
	private String createDateTo;
	private String billNo;
	private String type; 
	private String idStr;
	private String orderNo;
	private String relatedCompyExecel;



	public String getRelatedCompyExecel() {
		return relatedCompyExecel;
	}

	public void setRelatedCompyExecel(String relatedCompyExecel) {
		this.relatedCompyExecel = relatedCompyExecel;
	}

	public String getRpFlag() {
		return rpFlag;
	}
	public void setRpFlag(String rpFlag) {
		this.rpFlag = rpFlag;
	}
	public String getDirectFlag() {
		return directFlag;
	}
	public void setDirectFlag(String directFlag) {
		this.directFlag = directFlag;
	}
	public String getFeeStatus() {
		return feeStatus;
	}
	public void setFeeStatus(String feeStatus) {
		this.feeStatus = feeStatus;
	}
	public String getReconFlag() {
		return reconFlag;
	}
	public void setReconFlag(String reconFlag) {
		this.reconFlag = reconFlag;
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
	public String getPiCode() {
		return piCode;
	}
	public void setPiCode(String piCode) {
		this.piCode = piCode;
	}
	public String getRelatedCompy() {
		return relatedCompy;
	}
	public void setRelatedCompy(String relatedCompy) {
		this.relatedCompy = relatedCompy;
	}
	public String getOccurDateFrom() {
		return occurDateFrom;
	}
	public void setOccurDateFrom(String occurDateFrom) {
		this.occurDateFrom = occurDateFrom;
	}
	public String getOccurDateTo() {
		return occurDateTo;
	}
	public void setOccurDateTo(String occurDateTo) {
		this.occurDateTo = occurDateTo;
	}
	public String getCreateDateFrom() {
		return createDateFrom;
	}
	public void setCreateDateFrom(String createDateFrom) {
		this.createDateFrom = createDateFrom;
	}
	public String getCreateDateTo() {
		return createDateTo;
	}
	public void setCreateDateTo(String createDateTo) {
		this.createDateTo = createDateTo;
	}
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIdStr() {
		return idStr;
	}
	public void setIdStr(String idStr) {
		this.idStr = idStr;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

}
