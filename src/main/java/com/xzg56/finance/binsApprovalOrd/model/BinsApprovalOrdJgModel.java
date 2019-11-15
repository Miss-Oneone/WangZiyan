package com.xzg56.finance.binsApprovalOrd.model;


import com.xzg56.core.persistence.BaseModel;

public class BinsApprovalOrdJgModel extends BaseModel {
	private static final long serialVersionUID = 1L;
	private String orderNo; //订单编号
	private String orderNoF; //订单编号
	private String businessNo1; //提单号
	private String businessNo2; //箱号
	private String businessNo3; //箱号
	private String containerType; //箱型
	private String cusCode; //客户
	private String businessDate; //发车日期
	private double rAmountSum; //应收合计
	private double pAmountSum; //应付合计
	private double rTaxAmountSum; //销项税额合计
	private double pTaxAmountSum; //进项税额合计
	private String profit; //利润
	private String profitRate; //利润率
	private String binsApprovalFlag; //业务审核通过标记
	private String remarks; //备注
	private String relateCompyCode;

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderNoF() {
		return orderNoF;
	}

	public void setOrderNoF(String orderNoF) {
		this.orderNoF = orderNoF;
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

	public String getCusCode() {
		return cusCode;
	}

	public void setCusCode(String cusCode) {
		this.cusCode = cusCode;
	}

	public String getBusinessDate() {
		return businessDate;
	}

	public void setBusinessDate(String businessDate) {
		this.businessDate = businessDate;
	}

	public double getrAmountSum() {
		return rAmountSum;
	}

	public void setrAmountSum(double rAmountSum) {
		this.rAmountSum = rAmountSum;
	}

	public double getpAmountSum() {
		return pAmountSum;
	}

	public void setpAmountSum(double pAmountSum) {
		this.pAmountSum = pAmountSum;
	}

	public String getProfit() {
		return profit;
	}

	public void setProfit(String profit) {
		this.profit = profit;
	}

	public String getProfitRate() {
		return profitRate;
	}

	public void setProfitRate(String profitRate) {
		this.profitRate = profitRate;
	}

	public String getBinsApprovalFlag() {
		return binsApprovalFlag;
	}

	public void setBinsApprovalFlag(String binsApprovalFlag) {
		this.binsApprovalFlag = binsApprovalFlag;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getRelateCompyCode() {
		return relateCompyCode;
	}

	public void setRelateCompyCode(String relateCompyCode) {
		this.relateCompyCode = relateCompyCode;
	}

	public String getBusinessNo3() {
		return businessNo3;
	}

	public void setBusinessNo3(String businessNo3) {
		this.businessNo3 = businessNo3;
	}

	public double getrTaxAmountSum() {
		return rTaxAmountSum;
	}

	public void setrTaxAmountSum(double rTaxAmountSum) {
		this.rTaxAmountSum = rTaxAmountSum;
	}

	public double getpTaxAmountSum() {
		return pTaxAmountSum;
	}

	public void setpTaxAmountSum(double pTaxAmountSum) {
		this.pTaxAmountSum = pTaxAmountSum;
	}

	public String getContainerType() {
		return containerType;
	}

	public void setContainerType(String containerType) {
		this.containerType = containerType;
	}
}
