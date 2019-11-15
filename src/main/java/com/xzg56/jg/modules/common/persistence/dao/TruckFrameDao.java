package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.TruckFrame;
import org.apache.ibatis.annotations.Param;

/**
 * Created by wellen on 2019/4/3.
 */
@MyBatisDao
public interface TruckFrameDao extends BaseDao<TruckFrame> {

    TruckFrame get(@Param("id") int id);

    TruckFrame getByFrameCardNo(@Param("frameCardNo") String frameCardNo);
}
