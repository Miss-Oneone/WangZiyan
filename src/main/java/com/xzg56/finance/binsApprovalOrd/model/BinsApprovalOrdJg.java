package com.xzg56.finance.binsApprovalOrd.model;

import com.xzg56.core.persistence.IdEntity;

public class BinsApprovalOrdJg extends IdEntity<BinsApprovalOrd> {
	private static final long serialVersionUID = 1L;

	private String businessDateFrom; //拖箱时间
	private String businessDateTo; //拖箱时间
	private String binsApprovalFlag;//审核状态
	private String businessNo1; //提单号
	private String businessNo2; //箱号
	private String businessNo3;
	private String createBy; //创建人
	private String cusCode; //托运人
	private String orderNo;//订单号
	private String type;//页面类型
	private String relatedCompyCode;//往来单位CODE
	private String profitFrom;
	private String profitTo;
	private String containerType;

	public String getBusinessDateFrom() {
		return businessDateFrom;
	}

	public void setBusinessDateFrom(String businessDateFrom) {
		this.businessDateFrom = businessDateFrom;
	}

	public String getBusinessDateTo() {
		return businessDateTo;
	}

	public void setBusinessDateTo(String businessDateTo) {
		this.businessDateTo = businessDateTo;
	}

	public String getBinsApprovalFlag() {
		return binsApprovalFlag;
	}

	public void setBinsApprovalFlag(String binsApprovalFlag) {
		this.binsApprovalFlag = binsApprovalFlag;
	}

	public String getBusinessNo1() {
		return businessNo1;
	}

	public void setBusinessNo1(String businessNo1) {
		this.businessNo1 = businessNo1;
	}

	public String getBusinessNo2() {
		return businessNo2;
	}

	public void setBusinessNo2(String businessNo2) {
		this.businessNo2 = businessNo2;
	}

	@Override
	public String getCreateBy() {
		return createBy;
	}

	@Override
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getCusCode() {
		return cusCode;
	}

	public void setCusCode(String cusCode) {
		this.cusCode = cusCode;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRelatedCompyCode() {
		return relatedCompyCode;
	}

	public void setRelatedCompyCode(String relatedCompyCode) {
		this.relatedCompyCode = relatedCompyCode;
	}

	public String getProfitFrom() {
		return profitFrom;
	}

	public void setProfitFrom(String profitFrom) {
		this.profitFrom = profitFrom;
	}

	public String getProfitTo() {
		return profitTo;
	}

	public void setProfitTo(String profitTo) {
		this.profitTo = profitTo;
	}

	public String getContainerType() {
		return containerType;
	}

	public void setContainerType(String containerType) {
		this.containerType = containerType;
	}

	public String getBusinessNo3() {
		return businessNo3;
	}

	public void setBusinessNo3(String businessNo3) {
		this.businessNo3 = businessNo3;
	}
}
