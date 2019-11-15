package com.xzg56.jg.modules.yard.service;

import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.common.domain.IAttatchmentDomain;
import com.xzg56.jg.modules.common.domain.IYardDomain;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlan;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportDtl;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportHd;
import com.xzg56.jg.modules.yard.dao.YardDao;
import com.xzg56.jg.modules.yard.model.HeapPlanImportExcelModel;
import com.xzg56.jg.modules.yard.model.HeapPlanImportModel;
import com.xzg56.jg.modules.yard.model.HeapPlanModel;
import com.xzg56.jg.modules.yard.model.HeapPlanSearchModel;
import com.xzg56.utility.CollectionUtils;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;
import com.xzg56.utility.excel.ImportExcel;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.*;

/**
 * Created by wellen on 2019/8/21.
 */

@Service
@Transactional(readOnly = true)
public class YardService extends BaseService {
    public static final String GOODS_NO_LABEL = "货号";

    @Resource
    private IAttatchmentDomain attatchmentDomain;

    @Resource
    private IYardDomain yardDomain;

    @Resource
    private YardDao yardDao;

    @Transactional(readOnly = false)
    public void doImport(MultipartFile[] files) throws IOException {
        ImportExcel ei;
        for (MultipartFile file : files) {
            String suffixName = validateFile(file);
            // 解析excel文件
            List<HeapPlanImportExcelModel> plans;
            try {
                ei = new ImportExcel(file, 0, 0);
                plans = ei.getDataList(HeapPlanImportExcelModel.class);
            } catch (Exception e) {
                logger.error("导入文件时解析文件失败：", e);
                throw new ValidationException("解析文件失败：" + file.getOriginalFilename());
            }

            // 保存数据
            if (plans != null) {
                List<HeapPlanImportModel> importModels = new ArrayList<>();
                String goodsNo = null, goodsOweQuantity = null, customsClearanceDate = null;
                List<HeapPlanImportDtl> dtls = new ArrayList<>();
                int idx = 0;
                boolean lastFlag = false;
                for (HeapPlanImportExcelModel plan : plans) {
                    idx++;
                    // 跳过空白行,第一个表头行
                    if (StringUtils.isBlank(plan.getContnNo()) || (StringUtils.equals(plan.getGoodsNo(), GOODS_NO_LABEL) && idx == 1)) {
                        if (idx == plans.size()) {
                            lastFlag = true;
                        } else {
                            continue;
                        }
                    }

                    if (!StringUtils.equals(plan.getGoodsNo(), GOODS_NO_LABEL) && !lastFlag) {

                        if (StringUtils.isNotBlank(plan.getGoodsNo())) {
                            goodsNo = plan.getGoodsNo();
                        }
                        if (StringUtils.isNotBlank(plan.getGoodsOweQuantity())) {
                            goodsOweQuantity = plan.getGoodsOweQuantity();
                        }
                        if (StringUtils.isNotBlank(plan.getCustomsClearanceDate())) {
                            customsClearanceDate = dateFormate(plan.getCustomsClearanceDate());
                        }

                        HeapPlanImportDtl dtl = new HeapPlanImportDtl();
                        dtl.setContnNo(plan.getContnNo());
                        dtl.setSealNo(plan.getSealNo());
//                        dtl.setReportSts(plan.getReportSts());
//                        dtl.setPosition(plan.getPosition());
//                        dtl.setStorageNo(plan.getStorageNo());
//                        dtl.setPlateLoading(plan.getPlateLoading());
                        dtl.setQuantity(StringUtils.toInteger(plan.getQuantity()));
                        dtl.setUnloadingDate(DateUtils.parseDate(dateFormate(plan.getUnloadingDate())));
                        dtls.add(dtl);
                    }


                    // 以货号表头作为下一批次开始的判断，第一次跳过
                    if (StringUtils.equals(plan.getGoodsNo(), GOODS_NO_LABEL) || idx == plans.size()) {
                        if (idx == 1) {
                            continue;
                        }

                        HeapPlanImportModel importModel = new HeapPlanImportModel();
                        importModel.setGoodsNo(goodsNo);
                        importModel.setGoodsOweQuantity(goodsOweQuantity);
                        importModel.setCustomsClearanceDate(customsClearanceDate);
                        importModel.getDtls().addAll(dtls);
                        importModels.add(importModel);
                        dtls.clear();
                        goodsNo = null;
                        goodsOweQuantity = null;
                        customsClearanceDate = null;
                    }
                }

                // 附件路径保存第一个batchNo
                String batchNo = null;
                for (HeapPlanImportModel importModel : importModels) {
                    HeapPlanImportHd hd = new HeapPlanImportHd();
                    hd.setGoodsNo(importModel.getGoodsNo());
                    hd.setGoodsOweQuantity(StringUtils.toInteger(importModel.getGoodsOweQuantity()));
                    hd.setCustomsClearanceDate(importModel.getCustomsClearanceDate());
                    hd.setStatus(PjConstants.HEAP_PLAN_IMPORT_HD_STATUS.UNTREATED);
                    yardDomain.registerHeapPlanImportHd(hd);
                    if (StringUtils.isBlank(batchNo)) {
                        batchNo = hd.getBatchNo();
                    }

                    for (HeapPlanImportDtl dtl : importModel.getDtls()) {
                        dtl.setHeapPlanImportHdId(hd.getId().intValue());
                        yardDomain.registerHeapPlanImportDtl(dtl);
                    }
                }

                attatchmentDomain.upload(file, PjConstants.ATTACHMENT_FUNC_TYPE.YARD, batchNo, null, suffixName);
            }
        }
    }

    public List<HeapPlanModel> listHeapPlans(HeapPlanSearchModel searchModel) {
        List<HeapPlanModel> planModels = yardDao.listHeapPlans(searchModel);
        List<Dict> statuses = DictUtils.getDictList(PjConstants.HEAP_PLAN);
        for (HeapPlanModel planModel : planModels) {
            for (Dict status :statuses) {
                if (StringUtils.equals(planModel.getStatus(), status.getValue())) {
                    planModel.setStatus(status.getLabel());
                    break;
                }
            }
        }

        return planModels;
    }

    public List<HeapPlanModel> listHeapPlanImportHds(HeapPlanSearchModel searchModel) {
        List<HeapPlanModel> heapPlanImportHds = yardDao.listHeapPlanImportHds(searchModel);
        List<Dict> statuses = DictUtils.getDictList(PjConstants.HEAP_PLAN_IMPORT_HD);
        for (HeapPlanModel heapPlanImportHd : heapPlanImportHds) {
            for (Dict status :statuses) {
                if (StringUtils.equals(heapPlanImportHd.getStatus(), status.getValue())) {
                    heapPlanImportHd.setStatus(status.getLabel());
                    break;
                }
            }
        }

        return heapPlanImportHds;
    }

    @Transactional(readOnly = false)
    public void deleteHd(List<String> heapPlanImportHdIds) {
        yardDomain.deleteHeapImport(heapPlanImportHdIds);
    }

    public int totalPlansByStatus(HeapPlanSearchModel searchModel, String status) {
        searchModel.setStatus(status);
        return yardDao.totalPlansByStatus(searchModel);
    }

    public List<HeapPlanModel> listHeapPlanImportDtls(HeapPlanSearchModel searchModel) {
        List<HeapPlanModel> dtls = yardDao.listHeapPlanImportDtls(searchModel);
        // 10000没有特殊意思，只是想把数据往后面排
        for (HeapPlanModel dtl : dtls) {
            if (StringUtils.equals(dtl.getCntNeedMoveContn(), "10000")) {
                dtl.setCntNeedMoveContn("未知");
            }
            if (StringUtils.isBlank(dtl.getMainSameHeapContnNos())) {
                dtl.setMainSameHeapContnNos(dtl.getSameHeapContnNos());
            }
            if (StringUtils.isNotBlank(dtl.getMainSameHeapContnNos())) {
                String[] sameHeapContnNoArr = StringUtils.split(dtl.getMainSameHeapContnNos(), ",");
                dtl.setCntSameHeapContnNos(sameHeapContnNoArr.length);
            }
        }

        return dtls;
    }


    @Transactional(readOnly = false)
    public void createHeapPlan(List<Integer> heapImportDtlIds, String batchNo, String planDate, String referFlag) {
        List<HeapPlanModel> planModels = yardDao.listHeapPlanImportDtlsByIds(heapImportDtlIds);
        for (HeapPlanModel plan : planModels) {
            HeapPlan heapPlan = new HeapPlan();
            heapPlan.setContnNo(plan.getContnNo());
            heapPlan.setStatus(PjConstants.HEAP_PLAN_STATUS.UNTREATED);
            heapPlan.setPlanDate(DateUtils.parseDate(planDate));
            heapPlan.setSealNo(plan.getSealNo());
            heapPlan.setReportSts(plan.getReportSts());
            heapPlan.setPosition(plan.getPosition());
            heapPlan.setStorageNo(plan.getStorageNo());
            heapPlan.setQuantity(plan.getQuantity());
            heapPlan.setPlateLoading(plan.getPlateLoading());
            heapPlan.setUnloadingDate(DateUtils.parseDate(plan.getUnloadingDate()));
            heapPlan.setReferFlag(referFlag);
            yardDomain.getHeapPlanDao().insert(heapPlan);
        }
        yardDomain.updateHeapPlanImportStatusByBatchNo(batchNo);
    }

    public HeapPlanImportHd getHdByBatchNo(String batchNo) {
        return yardDomain.getHeapPlanImportHdDao().getByBatchNo(batchNo);
    }

    @Transactional(readOnly = false)
    public void updatePlanDate(List<String> planIds, String planDate) {
        yardDomain.batchUpdatePlanDate(planIds, planDate);
    }

    public int countHeapContns() {
        return yardDao.totalHeapContns();
    }

    public List<HeapPlanModel> listMultBatchHeapPlanImportDtls(List<String> batchNos) {
        List<HeapPlanModel> dtls = yardDao.listMultBatchHeapPlanImportDtls(batchNos);
        // 10000没有特殊意思，只是想把数据往后面排
        for (HeapPlanModel dtl : dtls) {
            if (StringUtils.equals(dtl.getCntNeedMoveContn(), "10000")) {
                dtl.setCntNeedMoveContn("未知");
                dtl.setHeapNo("系统里没有的箱子");
            }
        }


        List<HeapPlanModel> heapPlanDtls = new ArrayList<>();
        Map<String, List<HeapPlanModel>> groupMap = new HashedMap();
        int cnt = 0;
        for (HeapPlanModel dtl : dtls) {
            String heapNo = dtl.getHeapNo();
            if (groupMap.containsKey(heapNo)) {
                groupMap.get(heapNo).add(dtl);
            } else {
                cnt++;
                List<HeapPlanModel> heapPlanModels = new ArrayList<>();
                heapPlanModels.add(dtl);
                groupMap.put(heapNo, heapPlanModels);
            }
        }

        for(Map.Entry<String, List<HeapPlanModel>> entry : groupMap.entrySet()){
            String mapKey = entry.getKey();
            List<HeapPlanModel> mapValue = entry.getValue();
            HeapPlanModel planDtl = new HeapPlanModel();
            planDtl.setActSize(dtls.size() + cnt);
            planDtl.setHeapNo(mapKey);
            planDtl.getHeapPlanModels().addAll(mapValue);
            heapPlanDtls.add(planDtl);
        }

        heapPlanDtls = CollectionUtils.sort(heapPlanDtls, "heapNo");

        return heapPlanDtls;
    }

    /**
     * 判断文件格式，支持xls、xlsx
     * @param file
     */
    private String validateFile(MultipartFile file) {
        String fileName = file.getOriginalFilename();
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        if(!(StringUtils.equals(suffixName, ".xlsx") || StringUtils.equals(suffixName, ".xls"))) {
            throw new ValidationException("请导入正确的EXCEL文件");
        }
        return suffixName;
    }

    /**
     * 1.去除数字和/、-之外的文本
     * 2.日期格式为2019/01/01会转变为数字（数字是以1900年为原点，到2019/01/01之间经过的天数），这里做日期转换处理
     * @param date
     * @return
     */
    private String dateFormate(String date) {
        if (StringUtils.isBlank(date)) {
            return "";
        }
        date = date.replaceAll("[^0-9\\-\\/]", "");

        if (date.indexOf("-") < 0) {
            Calendar calendar = new GregorianCalendar(1900,0,-1);
            Date d = calendar.getTime();
            Date businessDateVal = DateUtils.addDays(d, Integer.valueOf(date));
            date = DateUtils.formatDate(businessDateVal);
        }

        return date;
    }
}
