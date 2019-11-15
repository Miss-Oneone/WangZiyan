package com.xzg56.jg.modules.mst.gps.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.gps.model.GpsModel;
import com.xzg56.jg.modules.mst.gps.model.GpsSearchModel;

import java.util.List;

/**
 * Created by wzr on 2019/4/20.
 */
@MyBatisDao
public interface GpsDao {
    List<GpsModel> findGpsSearchModelList(GpsSearchModel gpsSearchModel);
}
