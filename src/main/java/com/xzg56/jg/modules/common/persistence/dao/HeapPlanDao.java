package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlan;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/8/26.
 */

@MyBatisDao
public interface HeapPlanDao extends BaseDao<HeapPlan> {
    HeapPlan get(@Param("id") int id);

    List<HeapPlan> listByIds(List<String> planIds);
}
