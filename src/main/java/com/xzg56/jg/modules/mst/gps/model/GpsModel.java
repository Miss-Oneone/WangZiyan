package com.xzg56.jg.modules.mst.gps.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wzr on 2019/4/20.
 */
@Getter
@Setter
public class GpsModel extends BaseModel {

    private String plateNum;//车牌号
    private String mileSum;//公里数
    private String beginTime;//开始时间
    private String endTime;//结束时间
    private String createBy;
    private String createTime;
    private String updateBy;
    private String updateTime;
}
