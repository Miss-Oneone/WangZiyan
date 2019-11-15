package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/5/20.
 */

@Getter
@Setter
@Table(name = "mst_zx_address")
public class ZxAddress extends IdEntity<ZxAddress> {
    @Column(name = "NAME")
    private String name;//名称

    @Column(name = "PROVINCE_CODE")
    private String provinceCode;//省

    @Column(name = "CITY_CODE")
    private String cityCode;//市

    @Column(name = "DISTRICT_CODE")
    private String districtCode;//区/县

    @Column(name = "COUNTY_CODE")
    private String countyCode;//乡/镇

    @Column(name = "ADDRESS")
    private String address;//地址

    @Column(name = "CONTACT_PERSON")
    private String contactPerson;//联系人1

    @Column(name = "CONTACT_PHONE")
    private String contactPhone    ;//联系电话1

    @Column(name = "CONTACT_PERSON2")
    private String contactPerson2;//联系人2

    @Column(name = "CONTACT_PHONE2")
    private String contactPhone2;//联系电话2

    @Column(name = "CONTACT_PERSON3")//联系人3
    private String contactPerson3;

    @Column(name = "CONTACT_PHONE3")//联系电话3
    private String contactPhone3;

    @Column(name = "DELETED_FLAG")
    private String deletedFlag;//删除标志

    @Column(name = "RELATED_COMPY_CODE")
    private String relatedCompyCode;
}
