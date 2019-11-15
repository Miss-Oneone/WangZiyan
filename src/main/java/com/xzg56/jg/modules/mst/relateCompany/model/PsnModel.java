package com.xzg56.jg.modules.mst.relateCompany.model;


import com.xzg56.core.persistence.BaseModel;

/**
 * Created by cjx on 2019/03/22
 */

public class PsnModel extends BaseModel {

    private String relatedCompyCode;//往来单位编码

    private String relatedPsnName;//联系人姓名

    private String relatedPsnPosition;//联系人职位

    private String relatedPsnTel1;//联系人电话1

    private String relatedPsnTel2;//联系人电话2

    private String relatedPsnTel3;//联系人电话3

    private String beforeRelatedPsnName;

    private String createPsn;//创建人

    private String createTime;//创建时间

    private String updatePsn;//更新人

    private String updateTime;//更新时间


    public String getRelatedCompyCode() {
        return relatedCompyCode;
    }

    public void setRelatedCompyCode(String relatedCompyCode) {
        this.relatedCompyCode = relatedCompyCode;
    }

    public String getRelatedPsnName() {
        return relatedPsnName;
    }

    public void setRelatedPsnName(String relatedPsnName) {
        this.relatedPsnName = relatedPsnName;
    }

    public String getRelatedPsnPosition() {
        return relatedPsnPosition;
    }

    public void setRelatedPsnPosition(String relatedPsnPosition) {
        this.relatedPsnPosition = relatedPsnPosition;
    }

    public String getRelatedPsnTel1() {
        return relatedPsnTel1;
    }

    public void setRelatedPsnTel1(String relatedPsnTel1) {
        this.relatedPsnTel1 = relatedPsnTel1;
    }

    public String getRelatedPsnTel2() {
        return relatedPsnTel2;
    }

    public void setRelatedPsnTel2(String relatedPsnTel2) {
        this.relatedPsnTel2 = relatedPsnTel2;
    }

    public String getRelatedPsnTel3() {
        return relatedPsnTel3;
    }

    public void setRelatedPsnTel3(String relatedPsnTel3) {
        this.relatedPsnTel3 = relatedPsnTel3;
    }

    public String getCreatePsn() {
        return createPsn;
    }

    public void setCreatePsn(String createPsn) {
        this.createPsn = createPsn;
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

    public String getBeforeRelatedPsnName() {
        return beforeRelatedPsnName;
    }

    public void setBeforeRelatedPsnName(String beforeRelatedPsnName) {
        this.beforeRelatedPsnName = beforeRelatedPsnName;
    }
}
