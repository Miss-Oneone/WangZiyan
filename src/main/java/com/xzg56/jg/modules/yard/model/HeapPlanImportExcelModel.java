package com.xzg56.jg.modules.yard.model;


import com.xzg56.core.persistence.BaseModel;
import com.xzg56.utility.excel.annotation.ExcelField;

/**
 * Created by wellen on 2019/8/26.
 */

public class HeapPlanImportExcelModel extends BaseModel {

    private String goodsNo;
    private String goodsOweQuantity;
    private String customsClearanceDate;
    private String contnNo;
    private String sealNo;
//    private String reportSts;
//    private String position;
//    private String storageNo;
    private String quantity;
//    private String plateLoading;
    private String unloadingDate;

    @ExcelField(title="货号", align=2, sort=10)
    public String getGoodsNo() {
        return goodsNo;
    }

    public void setGoodsNo(String goodsNo) {
        this.goodsNo = goodsNo;
    }

    @ExcelField(title="欠货数量", align=2, sort=20)
    public String getGoodsOweQuantity() {
        return goodsOweQuantity;
    }

    public void setGoodsOweQuantity(String goodsOweQuantity) {
        this.goodsOweQuantity = goodsOweQuantity;
    }

    @ExcelField(title="结关日", align=2, sort=30)
    public String getCustomsClearanceDate() {
        return customsClearanceDate;
    }

    public void setCustomsClearanceDate(String customsClearanceDate) {
        this.customsClearanceDate = customsClearanceDate;
    }

    @ExcelField(title="柜号", align=2, sort=40)
    public String getContnNo() {
        return contnNo;
    }

    public void setContnNo(String contnNo) {
        this.contnNo = contnNo;
    }

    @ExcelField(title="封铅号", align=2, sort=50)
    public String getSealNo() {
        return sealNo;
    }

    public void setSealNo(String sealNo) {
        this.sealNo = sealNo;
    }

//    @ExcelField(title="申报状态", align=2, sort=60)
//    public String getReportSts() {
//        return reportSts;
//    }
//
//    public void setReportSts(String reportSts) {
//        this.reportSts = reportSts;
//    }

//    @ExcelField(title="停放位置", align=2, sort=70)
//    public String getPosition() {
//        return position;
//    }
//
//    public void setPosition(String position) {
//        this.position = position;
//    }

//    @ExcelField(title="进仓批号", align=2, sort=80)
//    public String getStorageNo() {
//        return storageNo;
//    }
//
//    public void setStorageNo(String storageNo) {
//        this.storageNo = storageNo;
//    }

    @ExcelField(title="箱数", align=2, sort=90)
    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

//    @ExcelField(title="板装", align=2, sort=100)
//    public String getPlateLoading() {
//        return plateLoading;
//    }
//
//    public void setPlateLoading(String plateLoading) {
//        this.plateLoading = plateLoading;
//    }

    @ExcelField(title="卸柜日期", align=2, sort=110)
    public String getUnloadingDate() {
        return unloadingDate;
    }

    public void setUnloadingDate(String unloadingDate) {
        this.unloadingDate = unloadingDate;
    }
}
