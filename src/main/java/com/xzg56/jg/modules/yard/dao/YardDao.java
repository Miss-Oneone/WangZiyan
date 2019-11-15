package com.xzg56.jg.modules.yard.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.yard.model.HeapPlanModel;
import com.xzg56.jg.modules.yard.model.HeapPlanSearchModel;

import java.util.List;

/**
 * Created by wellen on 2019/8/27.
 */

@MyBatisDao
public interface YardDao {
    List<HeapPlanModel> listHeapPlans(HeapPlanSearchModel searchModel);

    List<HeapPlanModel> listHeapPlanImportHds(HeapPlanSearchModel searchModel);

    List<HeapPlanModel> listHeapPlanImportDtls(HeapPlanSearchModel searchModel);

    List<HeapPlanModel> listMultBatchHeapPlanImportDtls(List<String> batchNos);

    List<HeapPlanModel> listHeapPlanImportDtlsByIds(List<Integer> heapImportDtlIds);

    int totalPlansByStatus(HeapPlanSearchModel searchModel);

    int totalHeapContns();
}
