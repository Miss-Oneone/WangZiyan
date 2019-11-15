package com.xzg56.jg.modules.mst.truckframe.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.truckframe.model.TruckFrameModel;
import com.xzg56.jg.modules.mst.truckframe.model.TruckFrameSearchModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/4/3.
 */

@MyBatisDao
public interface TruckFrameManDao {
    List<TruckFrameModel> listTruckFrames(TruckFrameSearchModel searchModel);

    TruckFrameModel findTruckFrameById(@Param("truckFrameId") int truckFrameId);
}
