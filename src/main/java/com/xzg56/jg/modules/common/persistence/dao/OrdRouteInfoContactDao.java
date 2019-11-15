package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.OrdRouteInfoContact;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/4/28.
 */

@MyBatisDao
public interface OrdRouteInfoContactDao extends BaseDao<OrdRouteInfoContact> {
    OrdRouteInfoContact get(@Param("id") int id);

    List<OrdRouteInfoContact> listByRouteInfoId(@Param("routeInfoId") int routeInfoId);

    void deleteByRouteInfoId(@Param("routeInfoId") long routeInfoId);
}
