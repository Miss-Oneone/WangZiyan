package com.xzg56.jg.modules.api.gps.model;


import com.xzg56.core.persistence.BaseModel;

/**
 * Created on 2017/9/21.
 */
public class CarGpsCarInfoModel extends BaseModel {
    private String carId;
    private String carNo;
    private String deptId;
    private String isLeaf;

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getCarNo() {
        return carNo;
    }

    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getIsLeaf() {
        return isLeaf;
    }

    public void setIsLeaf(String isLeaf) {
        this.isLeaf = isLeaf;
    }
}
