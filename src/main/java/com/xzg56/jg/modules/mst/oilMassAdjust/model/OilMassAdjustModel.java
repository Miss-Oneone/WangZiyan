package com.xzg56.jg.modules.mst.oilMassAdjust.model;

import com.xzg56.core.persistence.IdEntity;

public class OilMassAdjustModel extends IdEntity<OilMassAdjustModel> {

    private static final long serialVersionUID = 1L;

    private String plateNum;//车牌号
    private String driverCode;//司机编码
    private String driverName;//司机姓名
    private String oilMass;//校正油量
    private String time;//校正日期
    private String remark;//校正备注

    private String timeFrom;
    private String timeTo;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getPlateNum() {
        return plateNum;
    }

    public void setPlateNum(String plateNum) {
        this.plateNum = plateNum;
    }

    public String getDriverCode() {
        return driverCode;
    }

    public void setDriverCode(String driverCode) {
        this.driverCode = driverCode;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getOilMass() {
        return oilMass;
    }

    public void setOilMass(String oilMass) {
        this.oilMass = oilMass;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getTimeFrom() {
        return timeFrom;
    }

    public void setTimeFrom(String timeFrom) {
        this.timeFrom = timeFrom;
    }

    public String getTimeTo() {
        return timeTo;
    }

    public void setTimeTo(String timeTo) {
        this.timeTo = timeTo;
    }
}
