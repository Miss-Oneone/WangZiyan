package com.xzg56.jg.modules.mst.gpsKmAdjust.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wzr on 2019/6/10.
 */
@Getter
@Setter
public class GPSKmAdjustModel extends IdEntity<GPSKmAdjustModel> {

    private String plateNum;//车牌号
    private String driverCode;//司机编码
    private String driverName;//司机姓名
    private String adjustKm;//校正公里数
    private String adjustTime;//校正日期
    private String adjustRemark;//校正备注

    private String timeFrom;
    private String timeTo;
}
