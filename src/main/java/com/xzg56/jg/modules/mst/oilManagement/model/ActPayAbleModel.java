package com.xzg56.jg.modules.mst.oilManagement.model;


import com.xzg56.core.persistence.BaseModel;

public class ActPayAbleModel extends BaseModel {

	/**
	 * 插入实付明细表的数据字段
	 */
	private static final long serialVersionUID = 1L;
	
	private String orderNo;				//运输订单号
	private double amount;				//实付金额
	private String pActDocNo1;			//实付凭证1
	private String drvordNo;			//派车单号
	private String operationPsn;		//操作人
	
	public String getOperationPsn() {
		return operationPsn;
	}
	public void setOperationPsn(String operationPsn) {
		this.operationPsn = operationPsn;
	}
	public String getDrvordNo() {
		return drvordNo;
	}
	public void setDrvordNo(String drvordNo) {
		this.drvordNo = drvordNo;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getpActDocNo1() {
		return pActDocNo1;
	}
	public void setpActDocNo1(String pActDocNo1) {
		this.pActDocNo1 = pActDocNo1;
	}

}
