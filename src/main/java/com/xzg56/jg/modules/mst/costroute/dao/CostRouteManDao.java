package com.xzg56.jg.modules.mst.costroute.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteModel;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteSearchModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/5/30.
 */

@MyBatisDao
public interface CostRouteManDao {

    List<CostRouteModel> listCostRoutes(CostRouteSearchModel searchModel);

    CostRouteModel findById(@Param("id") String id);

    int countByAdrs(CostRouteModel costRouteModel);
}
