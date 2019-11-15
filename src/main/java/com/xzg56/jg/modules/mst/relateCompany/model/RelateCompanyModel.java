package com.xzg56.jg.modules.mst.relateCompany.model;


import com.xzg56.jg.modules.mst.relateCompany.entity.MstRelatedCompy;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by CJX on 2019/03/25.
 */
@Getter
@Setter
public class RelateCompanyModel extends MstRelatedCompy {

    private String psnName;//联系人姓名

    private String psnPosition;//联系人职位

    private String psnPhone1;//联系人电话1

    private String psnPhone2;//联系人电话2

    private String psnPhone3;//联系人电话3

    private String userCode;//用户账号

    private String sysPhone;//员工电话

    private String psnPhone;// 往来单位页面-查询框-联系人电话

    private String objs;//接收导出的json

    private String helperCode;//司机助手账号

    private String sfzNo;//身份证号

    private String drvLicenceNo;//驾驶证号

    private String drvLicenceLevel;//驾驶证等级

    private String drvLicenceYear;//驾驶证获取年份

    private String certificateFlag;//从业资格证

    private String dangerousFlag;//危货证

    private String storageOil;//存油量(升)

    private String phone1;//司机手机号码1

    private String phone2;//司机手机号码2

    private String email;//邮箱

    private String quitFlag;//离职标志

    private String entryTime;//入职日期

    private String quitTime;//离职日期

    private String driverType;
}
