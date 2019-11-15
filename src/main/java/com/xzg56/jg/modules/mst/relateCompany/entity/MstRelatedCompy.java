package com.xzg56.jg.modules.mst.relateCompany.entity;


import com.xzg56.core.persistence.IdEntity;

import javax.persistence.Column;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by CJX on 2019/03/22
 */

@Table(name = "mst_related_compy")
public class MstRelatedCompy extends IdEntity<MstRelatedCompy> {
    private static final long serialVersionUID = 1L;

    @Column(name = "RELATED_COMPY_CODE")
    private String relatedCompyCode;//往来单位编码

    @Column(name = "RELATED_COMPY_TYPE")
    private String relatedCompyType;//往来单位类型

    @Column(name = "COMPY_SNAME")
    private String compySname;//简称

    @Column(name = "COMPY_FNAME")
    private String compyFname;//全称

    @Column(name = "ACTIVE_FLAG")
    private String activeFlag;//有效标志

    @Column(name = "ACCOUNT_CODE")
    private String accountCode;//合并结算编码

    @Column(name = "CREATE_BY")
    private String createPsn;//创建人

    @Column(name = "CREATE_TIME")
    private Date createTime;//创建时间

    @Column(name = "UPDATE_BY")
    private String updatePsn;//创建人

    @Column(name = "UPDATE_TIME")
    private Date updateTime;//创建时间

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

    public String getCompySname() {
        return compySname;
    }

    public void setCompySname(String compySname) {
        this.compySname = compySname;
    }

    public String getCompyFname() {
        return compyFname;
    }

    public void setCompyFname(String compyFname) {
        this.compyFname = compyFname;
    }

    @Override
    public String getActiveFlag() {
        return activeFlag;
    }

    @Override
    public void setActiveFlag(String activeFlag) {
        this.activeFlag = activeFlag;
    }

    public String getAccountCode() {
        return accountCode;
    }

    public void setAccountCode(String accountCode) {
        this.accountCode = accountCode;
    }

    public String getCreatePsn() {
        return createPsn;
    }

    public void setCreatePsn(String createPsn) {
        this.createPsn = createPsn;
    }

    @Override
    public Date getCreateTime() {
        return createTime;
    }

    @Override
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUpdatePsn() {
        return updatePsn;
    }

    public void setUpdatePsn(String updatePsn) {
        this.updatePsn = updatePsn;
    }

    @Override
    public Date getUpdateTime() {
        return updateTime;
    }

    @Override
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
