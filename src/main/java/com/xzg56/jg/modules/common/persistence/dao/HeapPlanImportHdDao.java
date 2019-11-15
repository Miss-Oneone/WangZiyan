package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportHd;
import org.apache.ibatis.annotations.Param;

/**
 * Created by wellen on 2019/8/26.
 */

@MyBatisDao
public interface HeapPlanImportHdDao extends BaseDao<HeapPlanImportHd> {
    HeapPlanImportHd get(@Param("id") String id);

    HeapPlanImportHd getByBatchNo(@Param("batchNo") String batchNo);
}
