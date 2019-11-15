package com.xzg56.jg.modules.finance.expense.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * 费用管理
 *
 * @author zyq 2019/03/28
 *
 */
@Getter
@Setter
public class EmRecPayModel extends BaseModel {
    private static final long serialVersionUID = 7799201005573537428L;

    private String recPayId;
    private String orderNo;
    private String piCode;
    private String piName;
    private String paymentType;
    private String feeType;
    private String amount;
    private String expDate;
    private String remarks;
    private String compyCode;
    private String binsApprovalFlag;
    private String binsApprovalPsn;
    private String binsApprovalRemark;
    private String reconAmount;
    private String reconTime;
    private String reconPsn;
    private String activeFlag;
    private String invoiceIssueNeedFlag;
    private String binsApprovalTime;
    private String systemAutoFlag;
    private String feeStatus;
    private String billAmount;
    private String editableFlag;
    private String createBy;
    private String createById;
    private String createTime;
    private String updateBy;
    private String updateTime;
    private String paymentName;
    private String feeName;
    private String compyName;
    private String binsApprovalFlagLabel;
    private String invoiceIssueNeedFlagLabel;
    private String systemAutoFlagLabel;
    private String feeStatusName;
    private String editableFlagLabel;
    private String[] orderNos;
    private String selectedOrderNum;
    private String selectOrderNos;
    private String fiDoneAmount;
    private String billNo;
    private String billStatus;
    private String billStatusName;
    private String invoiceNo;
    private String invoiceStatus;
    private String invoiceStatusName;
}
