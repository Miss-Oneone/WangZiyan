package com.xzg56.jg.modules.mst.zxaddress.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/5/20.
 */

@Getter
@Setter
public class ZxAddressSearchModel extends IdEntity {

    private String name;
    private String provinceCode;
    private String cityCode;
    private String districtCode;
    private String countyCode;
    private String address;
    private String contactPerson;
    private String contactPhone;
    private String cusCode;
    private String person;
    private String phone;
}
