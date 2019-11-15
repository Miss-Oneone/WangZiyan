package com.xzg56.jg.modules.common.domain;

import com.xzg56.jg.modules.common.persistence.dao.HeapPlanDao;
import com.xzg56.jg.modules.common.persistence.dao.HeapPlanImportDtlDao;
import com.xzg56.jg.modules.common.persistence.dao.HeapPlanImportHdDao;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportDtl;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportHd;

import java.util.List;

/**
 * Created by wellen on 2019/8/26.
 */
public interface IYardDomain {
    void registerHeapPlanImportHd(HeapPlanImportHd heapPlanImportHd);

    void registerHeapPlanImportDtl(HeapPlanImportDtl heapPlanImportDtl);

    void updateHeapPlanImportStatusByBatchNo(String batchNo);

    HeapPlanImportHdDao getHeapPlanImportHdDao();

    HeapPlanImportDtlDao getHeapPlanImportDtlDao();

    HeapPlanDao getHeapPlanDao();

    void deleteHeapImport(List<String> heapPlanImportHdIds);

    void batchUpdatePlanDate(List<String> planIds, String planDate);
}
