package com.xzg56.finance.feebatchmanage.model;


import com.xzg56.core.persistence.BaseModel;

/**
 *
 * @author wjn
 * @date 2019/1/3
 */
public class FeeBatchManageUpdateModel extends BaseModel {


	private static final long serialVersionUID = 4269878682677577347L;

	private String feeIdStr;
	private String paymentType;
	private String addAmount;
	private String amount;
	private String amountFlag;

	public String getFeeIdStr() {
		return feeIdStr;
	}

	public void setFeeIdStr(String feeIdStr) {
		this.feeIdStr = feeIdStr;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getAddAmount() {
		return addAmount;
	}

	public void setAddAmount(String addAmount) {
		this.addAmount = addAmount;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getAmountFlag() {
		return amountFlag;
	}

	public void setAmountFlag(String amountFlag) {
		this.amountFlag = amountFlag;
	}
}
