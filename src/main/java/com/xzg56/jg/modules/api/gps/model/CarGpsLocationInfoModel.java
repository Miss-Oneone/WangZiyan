package com.xzg56.jg.modules.api.gps.model;


import com.xzg56.core.persistence.BaseModel;

/**
 * Created on 2017/9/21.
 */
public class CarGpsLocationInfoModel extends BaseModel {
    private String carId;
    private String plateNum;
    private String gpsPlateNum;
    private String Lng;
    private String Lat;
    private String speed;
    private String direction;
    private String height;
    private String address;
    private String status;
    private String reportTime;

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getLng() {
        return Lng;
    }

    public void setLng(String lng) {
        Lng = lng;
    }

    public String getLat() {
        return Lat;
    }

    public void setLat(String lat) {
        Lat = lat;
    }

    public String getPlateNum() {
        return plateNum;
    }

    public void setPlateNum(String plateNum) {
        this.plateNum = plateNum;
    }

    public String getGpsPlateNum() {
        return gpsPlateNum;
    }

    public void setGpsPlateNum(String gpsPlateNum) {
        this.gpsPlateNum = gpsPlateNum;
    }

    public String getSpeed() {
        return speed;
    }

    public void setSpeed(String speed) {
        this.speed = speed;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReportTime() {
        return reportTime;
    }

    public void setReportTime(String reportTime) {
        this.reportTime = reportTime;
    }
}
