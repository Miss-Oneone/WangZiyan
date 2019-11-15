package com.xzg56.jg.modules.mst.oilManagement.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/17.
 */

@Getter
@Setter
public class OilBalanceSearchModel extends IdEntity<OilBalanceSearchModel> {
    private String dateFrom;
    private String dateTo;
    private String driverCode;
    private String plateNum;
}
