package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.OrdRouteInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/4/28.
 */

@MyBatisDao
public interface OrdRouteInfoDao extends BaseDao<OrdRouteInfo> {
    OrdRouteInfo get(@Param("id") int id);

    List<OrdRouteInfo> listByOrderNo(@Param("orderNo") String orderNo);

    void deleteByOrderNo(@Param("orderNo") String orderNo);
}
