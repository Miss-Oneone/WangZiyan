package com.xzg56.jg.modules.api.gps.model;


import com.xzg56.core.persistence.BaseModel;

/**
 * Created on 2017/9/21.
 */
public class CarGpsUserInfoModel extends BaseModel {
    private String userType;
    private String areaId;
    private String deptName;
    private String deptId;
    private String userName;
    private String userId;

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getAreaId() {
        return areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

}
