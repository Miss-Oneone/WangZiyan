package com.xzg56.jg.modules.extrawork.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wzr on 2019/10/22.
 */
@Getter
@Setter
public class ExtraWorkSearchModel extends IdEntity<ExtraWorkSearchModel> {

    private String occurDateFrom;
    private String occurDateTo;
    private String driverCode;
    private String extraWorkId;
    private String plateNum;
    private String frameId;
    private String contnNo;
}
