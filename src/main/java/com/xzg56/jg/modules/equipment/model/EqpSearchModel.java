package com.xzg56.jg.modules.equipment.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/8.
 */

@Getter
@Setter
public class EqpSearchModel extends IdEntity<EqpSearchModel> {
    private String dateFrom;
    private String dateTo;
    private String plateNum;
    private String frameNum;
    private String contnNo;
}
