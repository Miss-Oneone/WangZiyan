package com.xzg56.jg.modules.mst.zxaddress.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by xc on 2017/8/3.
 */

@Getter
@Setter
public class ZxAddressModel extends BaseModel {

    private String id;
    private String provinceName;//省名称
    private String cityName;//市名称
    private String districtName;//区/县名称
    private String countyName;//乡镇名称
    private String provinceCode;//省编码
    private String cityCode;//市编码
    private String districtCode;//区/县编码
    private String countyCode;//乡镇编码
    private String name;
    private String address;
    private String contactPerson;
    private String contactPhone;
    private String contactPerson2;
    private String contactPhone2;
    private String contactPerson3;
    private String contactPhone3;
    private String text;
    private String value;
    private String person;
    private String phone;
    private String cusCode;
    private String relatedCompyCode;
}
