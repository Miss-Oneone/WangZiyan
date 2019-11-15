package com.xzg56.jg.modules.mst.gps.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wzr on 2019/4/20.
 */
@Getter
@Setter
public class GpsSearchModel extends IdEntity<GpsSearchModel> {

    private String plateNum;
    private String dateFrom;
    private String dateTo;
}
