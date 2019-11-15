package com.xzg56.finance.directcostmanage.model;


import com.xzg56.core.persistence.IdEntity;

/**
 * Created by wjn on 2019/3/22.
 */
public class DirectCostJgModel extends IdEntity<DirectCostJgModel> {

    /**
     *
     */
    private static final long serialVersionUID = -7769388477276605832L;

    private String orderNo; //订单号
    private String ordSts; // 状态
    private String cusName; // 托运人
    private String businessDate; // 发车日期
    private String businessNo1; // 提单号
    private String businessNo2; // 柜号
    private String piName; // 费用名称
    private String amount; // 金额
    private String compySname; // 往来单位
    private String relatedCompyCode; // 往来单位code
    private String relatedCompyType; // 类型
    private String createPsn; // 创建人
    private String createTimeFmt;//创建时间
    private String updatePsn; // 更新人
    private String updateTimeFmt; // 更新时间
    private String paymentType; // 收付类型
    private String binsApprovalFlag; // 审批状态
    private String binsApprovalName; // 审批状态
    private String binsApprovalPsn; // 审批人
    private String paymentTypeName; // 收付类型名称
    private String systemAutoFlag; // 自动生成标志
    private String feeStatus;//费用状态
    private String compyFname; // 往来单位全称
    private String feeStatusName;//费用状态
    private String remarks; //备注
    private double fiDoneAmount;
    private double billAmount;
    private String fiDoneStsName;
    private String invoiceIssueNeedFlag;
    private String invoiceIssueNeedName;
    private String interGoods;
    private String plateNum;
    private String driverName;




    //条件部
    private String businessDateFrom;
    private String businessDateTo;
    private String createTimeFrom;
    private String createTimeTo;
    private String sign;
    private String cusCode;
    private String piCode;
    private String fiDoneSts;
    private String driverCode;
    private String containerType;


    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrdSts() {
        return ordSts;
    }

    public void setOrdSts(String ordSts) {
        this.ordSts = ordSts;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getBusinessDate() {
        return businessDate;
    }

    public void setBusinessDate(String businessDate) {
        this.businessDate = businessDate;
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

    public String getCompySname() {
        return compySname;
    }

    public void setCompySname(String compySname) {
        this.compySname = compySname;
    }

    public String getRelatedCompyCode() {
        return relatedCompyCode;
    }

    public void setRelatedCompyCode(String relatedCompyCode) {
        this.relatedCompyCode = relatedCompyCode;
    }

    public String getRelatedCompyType() {
        return relatedCompyType;
    }

    public void setRelatedCompyType(String relatedCompyType) {
        this.relatedCompyType = relatedCompyType;
    }

    public String getCreatePsn() {
        return createPsn;
    }

    public void setCreatePsn(String createPsn) {
        this.createPsn = createPsn;
    }

    public String getCreateTimeFmt() {
        return createTimeFmt;
    }

    public void setCreateTimeFmt(String createTimeFmt) {
        this.createTimeFmt = createTimeFmt;
    }

    public String getUpdatePsn() {
        return updatePsn;
    }

    public void setUpdatePsn(String updatePsn) {
        this.updatePsn = updatePsn;
    }

    public String getUpdateTimeFmt() {
        return updateTimeFmt;
    }

    public void setUpdateTimeFmt(String updateTimeFmt) {
        this.updateTimeFmt = updateTimeFmt;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getBinsApprovalFlag() {
        return binsApprovalFlag;
    }

    public void setBinsApprovalFlag(String binsApprovalFlag) {
        this.binsApprovalFlag = binsApprovalFlag;
    }

    public String getBinsApprovalName() {
        return binsApprovalName;
    }

    public void setBinsApprovalName(String binsApprovalName) {
        this.binsApprovalName = binsApprovalName;
    }

    public String getBinsApprovalPsn() {
        return binsApprovalPsn;
    }

    public void setBinsApprovalPsn(String binsApprovalPsn) {
        this.binsApprovalPsn = binsApprovalPsn;
    }

    public String getPaymentTypeName() {
        return paymentTypeName;
    }

    public void setPaymentTypeName(String paymentTypeName) {
        this.paymentTypeName = paymentTypeName;
    }

    public String getSystemAutoFlag() {
        return systemAutoFlag;
    }

    public void setSystemAutoFlag(String systemAutoFlag) {
        this.systemAutoFlag = systemAutoFlag;
    }

    public String getFeeStatus() {
        return feeStatus;
    }

    public void setFeeStatus(String feeStatus) {
        this.feeStatus = feeStatus;
    }

    public String getCompyFname() {
        return compyFname;
    }

    public void setCompyFname(String compyFname) {
        this.compyFname = compyFname;
    }

    public String getFeeStatusName() {
        return feeStatusName;
    }

    public void setFeeStatusName(String feeStatusName) {
        this.feeStatusName = feeStatusName;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public double getFiDoneAmount() {
        return fiDoneAmount;
    }

    public void setFiDoneAmount(double fiDoneAmount) {
        this.fiDoneAmount = fiDoneAmount;
    }

    public double getBillAmount() {
        return billAmount;
    }

    public void setBillAmount(double billAmount) {
        this.billAmount = billAmount;
    }

    public String getFiDoneStsName() {
        return fiDoneStsName;
    }

    public void setFiDoneStsName(String fiDoneStsName) {
        this.fiDoneStsName = fiDoneStsName;
    }

    public String getInvoiceIssueNeedFlag() {
        return invoiceIssueNeedFlag;
    }

    public void setInvoiceIssueNeedFlag(String invoiceIssueNeedFlag) {
        this.invoiceIssueNeedFlag = invoiceIssueNeedFlag;
    }

    public String getInvoiceIssueNeedName() {
        return invoiceIssueNeedName;
    }

    public void setInvoiceIssueNeedName(String invoiceIssueNeedName) {
        this.invoiceIssueNeedName = invoiceIssueNeedName;
    }

    public String getInterGoods() {
        return interGoods;
    }

    public void setInterGoods(String interGoods) {
        this.interGoods = interGoods;
    }

    public String getPlateNum() {
        return plateNum;
    }

    public void setPlateNum(String plateNum) {
        this.plateNum = plateNum;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

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

    public String getCreateTimeFrom() {
        return createTimeFrom;
    }

    public void setCreateTimeFrom(String createTimeFrom) {
        this.createTimeFrom = createTimeFrom;
    }

    public String getCreateTimeTo() {
        return createTimeTo;
    }

    public void setCreateTimeTo(String createTimeTo) {
        this.createTimeTo = createTimeTo;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode;
    }

    public String getPiCode() {
        return piCode;
    }

    public void setPiCode(String piCode) {
        this.piCode = piCode;
    }

    public String getFiDoneSts() {
        return fiDoneSts;
    }

    public void setFiDoneSts(String fiDoneSts) {
        this.fiDoneSts = fiDoneSts;
    }

    public String getDriverCode() {
        return driverCode;
    }

    public void setDriverCode(String driverCode) {
        this.driverCode = driverCode;
    }

    public String getContainerType() {
        return containerType;
    }

    public void setContainerType(String containerType) {
        this.containerType = containerType;
    }
}
