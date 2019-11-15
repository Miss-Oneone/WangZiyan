package com.xzg56.jg.modules.mst.relateCompany.model;


import com.xzg56.core.persistence.BaseModel;

/**
 * Created by cjx on 2019/03/22
 */

public class BankModel extends BaseModel {

    private String relatedCompyCode;//往来单位编码
    private String relatedAccountName;//账户名称
    private String relatedAccountNo;//账户号码
    private String relatedAccountBank;//开户行
    private String createPsn;
    private String createTime;
    private String updatePsn;
    private String updateTime;
    private String userId;
    private Long id;

    public String getCreatePsn() {
        return createPsn;
    }

    public void setCreatePsn(String createPsn) {
        this.createPsn = createPsn;
    }

    public String getRelatedCompyCode() {
        return relatedCompyCode;
    }

    public void setRelatedCompyCode(String relatedCompyCode) {
        this.relatedCompyCode = relatedCompyCode;
    }

    public String getRelatedAccountName() {
        return relatedAccountName;
    }

    public void setRelatedAccountName(String relatedAccountName) {
        this.relatedAccountName = relatedAccountName;
    }

    public String getRelatedAccountNo() {
        return relatedAccountNo;
    }

    public void setRelatedAccountNo(String relatedAccountNo) {
        this.relatedAccountNo = relatedAccountNo;
    }

    public String getRelatedAccountBank() {
        return relatedAccountBank;
    }

    public void setRelatedAccountBank(String relatedAccountBank) {
        this.relatedAccountBank = relatedAccountBank;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUpdatePsn() {
        return updatePsn;
    }

    public void setUpdatePsn(String updatePsn) {
        this.updatePsn = updatePsn;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
