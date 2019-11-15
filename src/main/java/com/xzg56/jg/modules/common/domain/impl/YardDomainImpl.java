package com.xzg56.jg.modules.common.domain.impl;


import com.xzg56.common.module.sys.basic.service.NumberingService;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.common.domain.IYardDomain;
import com.xzg56.jg.modules.common.persistence.dao.HeapPlanDao;
import com.xzg56.jg.modules.common.persistence.dao.HeapPlanImportDtlDao;
import com.xzg56.jg.modules.common.persistence.dao.HeapPlanImportHdDao;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlan;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportDtl;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportHd;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wellen on 2019/8/26.
 */

@Component
public class YardDomainImpl implements IYardDomain {
    @Resource
    private HeapPlanImportHdDao heapPlanImportHdDao;

    @Resource
    private HeapPlanImportDtlDao heapPlanImportDtlDao;

    @Resource
    private HeapPlanDao heapPlanDao;

    @Resource
    private NumberingService numberingService;

    @Override
    public void registerHeapPlanImportHd(HeapPlanImportHd heapPlanImportHd) {
        String batchNo = numberingService.getNumber(PjConstants.NUMBER_CODE.HEAP_PLAN_IMPORT_HD);
        heapPlanImportHd.setBatchNo(batchNo);
        heapPlanImportHdDao.insert(heapPlanImportHd);
    }

    @Override
    public void registerHeapPlanImportDtl(HeapPlanImportDtl heapPlanImportDtl) {
        heapPlanImportDtlDao.insert(heapPlanImportDtl);
    }

    @Override
    public void updateHeapPlanImportStatusByBatchNo(String batchNo) {
        HeapPlanImportHd hd = heapPlanImportHdDao.getByBatchNo(batchNo);
        if (hd != null) {
            hd.setStatus(PjConstants.HEAP_PLAN_IMPORT_HD_STATUS.PROCESSED);
            heapPlanImportHdDao.update(hd);
        }
    }

    @Override
    public HeapPlanImportHdDao getHeapPlanImportHdDao() {
        return heapPlanImportHdDao;
    }

    @Override
    public HeapPlanImportDtlDao getHeapPlanImportDtlDao() {
        return heapPlanImportDtlDao;
    }

    @Override
    public HeapPlanDao getHeapPlanDao() {
        return heapPlanDao;
    }

    @Override
    public void deleteHeapImport(List<String> heapPlanImportHdIds) {
        for (String hdId : heapPlanImportHdIds) {
            HeapPlanImportHd hd = heapPlanImportHdDao.get(hdId);
            if (hd != null) {
                heapPlanImportDtlDao.deleteByHeapImportHdId(StringUtils.toInteger(hdId));
                heapPlanImportHdDao.delete(hd);
            }
        }
    }

    @Override
    public void batchUpdatePlanDate(List<String> planIds, String planDate) {
        List<HeapPlan> plans = heapPlanDao.listByIds(planIds);
        for (HeapPlan plan : plans) {
            plan.setPlanDate(DateUtils.parseDate(planDate));
            heapPlanDao.update(plan);
        }
    }
}
