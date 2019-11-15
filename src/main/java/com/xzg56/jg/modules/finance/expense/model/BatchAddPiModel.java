package com.xzg56.jg.modules.finance.expense.model;


import com.xzg56.core.persistence.IdEntity;

public class BatchAddPiModel extends IdEntity<BatchAddPiModel> {

	private static final long serialVersionUID = 1L;
	private String selectedOrderNum;	//所选订单
	private String prFlag;				//收付类型
	private String piName;				//费用名称
	private String relatedCompy;		//往来单位
	private String relatedCompyPara;	//往来单位隐藏域使用
	private String drivePrFlag;			//司机代收付
	private String amount;				//金额
	private String expDate;				//预计日期
	private String expDatePara;			//预计日期隐藏域使用
	private String expDateParaNow;			//预计日期隐藏域使用
	private String remark;				//备注
	private String orderNo;				//订单
	private String[] orderNoStr;				//订单
	private String blNo;				//提单号
	private String contnNo;				//集装箱号
	private String containerType;		//集装箱类型
	private String checkResult;			//校验结果
	private String checkRemark;			//校验备注
	private String piCode;
	private String totalAmount;			//金额
	private String checkPiName; 		//费用名称检验
	private String selectOrderNo;
	private String CreatePsn;
	private String contnTime;
	private String relatedCompyCode;
	private String checkPiCode;
	private String PFitId;
	private String feeStatus;

	public String getFeeStatus() {
		return feeStatus;
	}

	public void setFeeStatus(String feeStatus) {
		this.feeStatus = feeStatus;
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
	public String getCheckResult() {
		return checkResult;
	}
	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}
	public String getCheckRemark() {
		return checkRemark;
	}
	public void setCheckRemark(String checkRemark) {
		this.checkRemark = checkRemark;
	}
	public String getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getCheckPiName() {
		return checkPiName;
	}
	public void setCheckPiName(String checkPiName) {
		this.checkPiName = checkPiName;
	}
	public String getSelectedOrderNum() {
		return selectedOrderNum;
	}
	public void setSelectedOrderNum(String selectedOrderNum) {
		this.selectedOrderNum = selectedOrderNum;
	}
	public String getPrFlag() {
		return prFlag;
	}
	public void setPrFlag(String prFlag) {
		this.prFlag = prFlag;
	}
	public String getPiName() {
		return piName;
	}
	public void setPiName(String piName) {
		this.piName = piName;
	}
	public String getRelatedCompy() {
		return relatedCompy;
	}
	public void setRelatedCompy(String relatedCompy) {
		this.relatedCompy = relatedCompy;
	}
	public String getDrivePrFlag() {
		return drivePrFlag;
	}
	public void setDrivePrFlag(String drivePrFlag) {
		this.drivePrFlag = drivePrFlag;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getExpDate() {
		return expDate;
	}
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String[] getOrderNoStr() {
		return orderNoStr;
	}
	public void setOrderNoStr(String[] orderNoStr) {
		this.orderNoStr = orderNoStr;
	}
	public String getSelectOrderNo() {
		return selectOrderNo;
	}
	public void setSelectOrderNo(String selectOrderNo) {
		this.selectOrderNo = selectOrderNo;
	}
	public String getPiCode() {
		return piCode;
	}
	public void setPiCode(String piCode) {
		this.piCode = piCode;
	}
	public String getCreatePsn() {
		return CreatePsn;
	}
	public void setCreatePsn(String createPsn) {
		CreatePsn = createPsn;
	}
	public String getContnTime() {
		return contnTime;
	}
	public void setContnTime(String contnTime) {
		this.contnTime = contnTime;
	}
	public String getRelatedCompyCode() {
		return relatedCompyCode;
	}
	public void setRelatedCompyCode(String relatedCompyCode) {
		this.relatedCompyCode = relatedCompyCode;
	}
	public String getCheckPiCode() {
		return checkPiCode;
	}
	public void setCheckPiCode(String checkPiCode) {
		this.checkPiCode = checkPiCode;
	}
	public String getRelatedCompyPara() {
		return relatedCompyPara;
	}
	public void setRelatedCompyPara(String relatedCompyPara) {
		this.relatedCompyPara = relatedCompyPara;
	}
	public String getExpDatePara() {
		return expDatePara;
	}
	public void setExpDatePara(String expDatePara) {
		this.expDatePara = expDatePara;
	}
	public String getExpDateParaNow() {
		return expDateParaNow;
	}
	public void setExpDateParaNow(String expDateParaNow) {
		this.expDateParaNow = expDateParaNow;
	}
	public String getPFitId() {
		return PFitId;
	}
	public void setPFitId(String pFitId) {
		PFitId = pFitId;
	}
	
	
}
