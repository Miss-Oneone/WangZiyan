package com.xzg56.jg.modules.mst.pricecontract.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/5/13.
 */

@Getter
@Setter
public class AddressModel extends BaseModel {
    private String name;
    private String provinceCode;
    private String cityCode;
    private String districtCode;
    private String countyCode;
}
