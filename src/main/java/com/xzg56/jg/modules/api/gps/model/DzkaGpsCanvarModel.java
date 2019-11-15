package com.xzg56.jg.modules.api.gps.model;


import com.xzg56.core.persistence.BaseModel;

/**
 * Created on 2018/3/16.
 */
public class DzkaGpsCanvarModel extends BaseModel {

    private String plateNum;//实际车牌号

    private String lng;//经度

    private String lat;//纬度

    private String height;//高度

    private String speed;//速度（公里每小时）

    private String directiom;//方向

    private String reportTime;//报告时间

    private String dlTime;//下载时间

    public String getPlateNum() {
        return plateNum;
    }

    public void setPlateNum(String plateNum) {
        this.plateNum = plateNum;
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getSpeed() {
        return speed;
    }

    public void setSpeed(String speed) {
        this.speed = speed;
    }

    public String getDirectiom() {
        return directiom;
    }

    public void setDirectiom(String directiom) {
        this.directiom = directiom;
    }

    public String getReportTime() {
        return reportTime;
    }

    public void setReportTime(String reportTime) {
        this.reportTime = reportTime;
    }

    public String getDlTime() {
        return dlTime;
    }

    public void setDlTime(String dlTime) {
        this.dlTime = dlTime;
    }
}
