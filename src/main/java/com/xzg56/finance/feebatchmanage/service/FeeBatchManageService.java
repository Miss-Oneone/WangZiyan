package com.xzg56.finance.feebatchmanage.service;

import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.finance.common.domain.IRPableDomain;
import com.xzg56.finance.common.persistence.dao.OrdReceiptsPaymentsDao;
import com.xzg56.finance.common.persistence.entity.OrdReceiptsPayments;
import com.xzg56.finance.feebatchmanage.dao.FeeBatchManageDao;
import com.xzg56.finance.feebatchmanage.model.FeeBatchManageModel;
import com.xzg56.finance.feebatchmanage.model.FeeBatchManageSearchModel;
import com.xzg56.finance.feebatchmanage.model.FeeBatchManageUpdateModel;
import com.xzg56.jg.modules.finance.expense.model.BatchAddPiModel;
import com.xzg56.utility.NumberUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wjn on 2017/6/6.
 */
@Service
@Transactional(readOnly = true)
public class FeeBatchManageService extends BaseService {

    @Resource
    private FeeBatchManageDao feeBatchManageDao;

    @Resource
    private OrdReceiptsPaymentsDao ordReceiptsPaymentsDao;

    @Resource
    private IRPableDomain irPableDomain;

    public List<FeeBatchManageModel> findFeeBatchManageList(FeeBatchManageSearchModel feeBatchManageSearchModel) {
        List<FeeBatchManageModel> feeBatchManageModelList = feeBatchManageDao.findFeeBatchManageList(feeBatchManageSearchModel);
        feeBatchManageModelList = transformDict(feeBatchManageModelList);
        return feeBatchManageModelList;
    }


    private List<FeeBatchManageModel> transformDict(List<FeeBatchManageModel> feeBatchManageModelList) {

        //商务审批状态
        List<Dict> binsApprovalSts = DictUtils.getDictList(BizFcConstants.GROUP_NO.BINS_APPROVAL_STATUS);
        //往来单位类型
        List<Dict> relatedCompyType = DictUtils.getDictList(BizFcConstants.GROUP_NO.RELATED_COMPY_TYPE);
        //订单状态
        List<Dict> ordSts = DictUtils.getDictList(BizFcConstants.GROUP_NO.ORD_STS_CODE);
        //内外贸
        List<Dict> binsType = DictUtils.getDictList(BizFcConstants.GROUP_NO.BINS_TYPE);
        //进出口
        List<Dict> ioType = DictUtils.getDictList(BizFcConstants.GROUP_NO.IO_TYPE);
        //岛内岛外
        List<Dict> sysConfirm = DictUtils.getDictList(BizFcConstants.GROUP_NO.SYS_CONFIRM_FLAG);
        //费用状态
        List<Dict> feeStatus = DictUtils.getDictList(BizFcConstants.GROUP_NO.FEE_STATUS);
        //收付类型
        List<Dict> paymentType = DictUtils.getDictList(BizFcConstants.GROUP_NO.PAYMENT_TYPE);
        //订单状态
        List<Dict> ordStsCode = DictUtils.getDictList(BizFcConstants.GROUP_NO.ORD_STS_CODE);

        //订单状态
        List<Dict> binsApprovalFlag = DictUtils.getDictList(BizFcConstants.GROUP_NO.BINS_APPROVAL_STATUS);

        for (FeeBatchManageModel model : feeBatchManageModelList) {
            for (Dict dict : paymentType) {
                if (StringUtils.equals(model.getPaymentType(), dict.getValue())) {
                    model.setPaymentTypeName(dict.getLabel());
                    break;
                }
            }

            for (Dict dict : feeStatus) {
                if (StringUtils.equals(model.getFeeStatus(), dict.getValue())) {
                    model.setFeeStatusName(dict.getLabel());
                    break;
                }
            }
            for (Dict dict : ordStsCode) {
                if (StringUtils.equals(model.getOrdStsCode(), dict.getValue())) {
                    model.setOrdStsName(dict.getLabel());
                    break;
                }
            }
            for (Dict dict : binsApprovalFlag) {
                if (StringUtils.equals(model.getBinsApprovalFlag(), dict.getValue())) {
                    model.setBinsApprovalFlagName(dict.getLabel());
                    break;
                }
            }
        }
        return feeBatchManageModelList;
    }

    public List<BatchAddPiModel> check(BatchAddPiModel batchAddPiModel) {

        String[] orderNoStr = batchAddPiModel.getOrderNo().split(",");
        batchAddPiModel.setOrderNoStr(orderNoStr);
        List<BatchAddPiModel> batchAddPiList = new ArrayList<BatchAddPiModel>();
        batchAddPiList = feeBatchManageDao.searchList(batchAddPiModel);

        for (BatchAddPiModel batchAddPiLi : batchAddPiList) {
            if (StringUtils.equals(batchAddPiLi.getCheckResult(), "0")) {
                batchAddPiLi.setCheckResult("通过");
            } else {
                batchAddPiLi.setCheckResult("费用已存在");
            }
        }
        return batchAddPiList;
    }

    @Transactional(readOnly = false)
    public void feeBatchSave(BatchAddPiModel batchAddPiModel) {
        String[] orderNoStr = null;
        orderNoStr = batchAddPiModel.getSelectOrderNo().split(",");
        OrdReceiptsPayments ordReceiptsPayments;
        for (int i = 0; i < orderNoStr.length; i++) {
            batchAddPiModel.setOrderNo(orderNoStr[i]);
            ordReceiptsPayments = transformOrdReceiptsPayments(batchAddPiModel);
            irPableDomain.registerOrdReceiptsPayments(ordReceiptsPayments);
        }
    }

    private OrdReceiptsPayments transformOrdReceiptsPayments(BatchAddPiModel batchAddPiModel) {
        OrdReceiptsPayments ordReceiptsPayments = new OrdReceiptsPayments();
        ordReceiptsPayments.setOrderNo(batchAddPiModel.getOrderNo());
        ordReceiptsPayments.setPiCode(batchAddPiModel.getPiCode());
        ordReceiptsPayments.setPiName(batchAddPiModel.getPiName());
        ordReceiptsPayments.setAmount(NumberUtils.toDouble(batchAddPiModel.getAmount()));
        ordReceiptsPayments.setCompyCode(batchAddPiModel.getRelatedCompy());
        ordReceiptsPayments.setExpDate(batchAddPiModel.getExpDate());
        ordReceiptsPayments.setFeeStatus(batchAddPiModel.getFeeStatus());
        ordReceiptsPayments.setFeeType(BizFcConstants.FEE_TYPE.DIRECT);
        ordReceiptsPayments.setPaymentType(batchAddPiModel.getPrFlag());
        ordReceiptsPayments.setActiveFlag(BizFcConstants.YES);
        ordReceiptsPayments.setRemarks(batchAddPiModel.getRemark());
        return ordReceiptsPayments;
    }

    @Transactional(readOnly = false)
    public void feeBatchManageSaveUpdate(FeeBatchManageUpdateModel feeBatchManageUpdateModel) {
        String[] idArray = StringUtils.split(feeBatchManageUpdateModel.getFeeIdStr(), ",");
        double amount = 0.00;
        double addAmount = 0.00;
        OrdReceiptsPayments ordReceiptsPayments;
        Long id;
        for (Integer i = 0; i < idArray.length; i++) {
            id = NumberUtils.toLong(idArray[i]);
            addAmount = NumberUtils.toDouble(feeBatchManageUpdateModel.getAddAmount());
            amount = NumberUtils.toDouble(feeBatchManageUpdateModel.getAmount());
            ordReceiptsPayments = ordReceiptsPaymentsDao.get(id);
            if (StringUtils.isBlank(ordReceiptsPayments)) {
                throw new ValidationException("存在费用已被删除，请重新选择");
            }
            if (StringUtils.equals("1", feeBatchManageUpdateModel.getAmountFlag())) {
                ordReceiptsPayments.setAmount(ordReceiptsPayments.getAmount() + addAmount);
            } else {
                ordReceiptsPayments.setAmount(amount);
            }
            irPableDomain.modifyOrdReceiptsPayments(ordReceiptsPayments);
        }
    }

    public boolean checkPassword(String password) {
        Dict dict = DictUtils.getDictList("FEE_PASSWORD").get(0);
        if(StringUtils.equals(dict.getValue(),password)) {
            return true;
        }
        return false;
    }
}
