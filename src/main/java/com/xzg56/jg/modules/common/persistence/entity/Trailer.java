package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.DataEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/4/8.
 */

@Getter
@Setter
@Table(name = "mst_trailer")
public class Trailer extends DataEntity<Trailer> {

    @Column(name = "PLATE_NUM")
    private String plateNum;

    @Column(name = "TRAILER_BELONG_TYPE")
    private String trailerBelongType;

    @Column(name = "ATTACH_DRV_CODE")
    private String attachDrvCode;

    @Column(name = "T_WHEEL_TYPE")
    private String tWheelType;

    @Column(name = "PRODUCTION_YEAR")
    private String productionYear;

    @Column(name = "AGE")
    private String age;

    @Column(name = "IDENTITY_NO")
    private String identityNo;

    @Column(name = "CURRENT_DRV_CODE")
    private String currentDrvCode;

    @Column(name = "CURRENT_CF_NUM")
    private String currentCfNum;

    @Column(name = "TANK_LITERS")
    private String tankLiters;

    @Column(name = "MAX_LOAD")
    private String maxLoad;

    @Column(name = "TRAILER_TYPE")
    private String trailerType;

    @Column(name = "FUEL_TYPE")
    private String fuelType;

    @Column(name = "COMPY")
    private String compy;

    @Column(name = "VALID_FLAG")
    private String validFlag;

    @Column(name = "SCRAP_TIME")
    private String scrapTime;

    @Column(name = "BUY_TIME")
    private String buyTime;

    @Column(name = "PRODUCT_MODEL")
    private String productModel;

    @Column(name = "ENGINE_NO")
    private String engineNo;

    @Column(name = "REMARKS")
    private String remarks;

    @Column(name = "ADDRESS")
    private String address;

    @Column(name = "LITERS")
    private String liters;

    @Column(name = "TRANSPORT_TYPE")
    private String transportType;
}
