package com.xzg56.jg.modules.mst.gpsKmAdjust.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.mst.gpsKmAdjust.model.GPSKmAdjustModel;

import java.util.List;

/**
 * Created by wzr on 2019/6/10.
 */
@MyBatisDao
public interface GPSKmAdjustDao extends BaseDao<GPSKmAdjustModel> {

    List<GPSKmAdjustModel> search(GPSKmAdjustModel gpsKmAdjustModel);

    void insertGPSKmAdjust(GPSKmAdjustModel gpsKmAdjustModel);

    void updateGPSKmAdjust(GPSKmAdjustModel gpsKmAdjustModel);
}
