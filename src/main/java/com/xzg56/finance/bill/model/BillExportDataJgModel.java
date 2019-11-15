package com.xzg56.finance.bill.model;


import com.xzg56.core.persistence.BaseModel;

public class BillExportDataJgModel extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2370601872577600257L;
	private String billNo; // 账单号
	private String directFlag; // 直接间接
	private String compySname; // 往来单位
	private String orderNo; // 订单号
	private String occurDate; // 发生时间
	private String blNo; // 提单号
	private String contnNo; // 箱号
	private String containerType; // 箱型

	private String piCode; // 二级费用分类编码
	private String piName; // 二级费用分类名称
	private String amount; // 金额
	private String prType;
	private String comments;// 对账导出备注
	private String excelTextCode;
	private String excelTextvalue;

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getDirectFlag() {
		return directFlag;
	}

	public void setDirectFlag(String directFlag) {
		this.directFlag = directFlag;
	}

	public String getCompySname() {
		return compySname;
	}

	public void setCompySname(String compySname) {
		this.compySname = compySname;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOccurDate() {
		return occurDate;
	}

	public void setOccurDate(String occurDate) {
		this.occurDate = occurDate;
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

	public String getContainerType() {
		return containerType;
	}

	public void setContainerType(String containerType) {
		this.containerType = containerType;
	}

	public String getPiCode() {
		return piCode;
	}

	public void setPiCode(String piCode) {
		this.piCode = piCode;
	}

	public String getPiName() {
		return piName;
	}

	public void setPiName(String piName) {
		this.piName = piName;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getPrType() {
		return prType;
	}

	public void setPrType(String prType) {
		this.prType = prType;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getExcelTextCode() {
		return excelTextCode;
	}

	public void setExcelTextCode(String excelTextCode) {
		this.excelTextCode = excelTextCode;
	}

	public String getExcelTextvalue() {
		return excelTextvalue;
	}

	public void setExcelTextvalue(String excelTextvalue) {
		this.excelTextvalue = excelTextvalue;
	}
}
