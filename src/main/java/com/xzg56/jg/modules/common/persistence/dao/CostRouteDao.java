package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.model.ContainerModel;
import com.xzg56.jg.modules.common.persistence.entity.CostRoute;
import org.apache.ibatis.annotations.Param;

/**
 * Created by wellen on 2019/5/30.
 */

@MyBatisDao
public interface CostRouteDao extends BaseDao<CostRoute> {
    CostRoute get(@Param("id") long id);

    CostRoute findByAddress(ContainerModel container);
}
