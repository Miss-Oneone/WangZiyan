package com.xzg56.jg.modules.yard.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/8/27.
 */

@Getter
@Setter
public class HeapPlanSearchModel extends IdEntity<HeapPlanSearchModel> {
    private String batchNo;
    private String dateFrom;
    private String dateTo;
    private String status;
}
