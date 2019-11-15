package com.xzg56.jg.modules.mst.truckframe.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/3.
 */

@Getter
@Setter
public class TruckFrameModel extends BaseModel {
    private int id;
    private String frameCardId;
    private String serialNo;
    private String frameNum;
    private String plateNum;
    private String status;
    private String statusCd;
    private String createBy;
    private String createTime;
    private String updateBy;
    private String updateTime;
    private boolean disabledFlag;
    private String frameTypeId;
    private String frameType;
}
