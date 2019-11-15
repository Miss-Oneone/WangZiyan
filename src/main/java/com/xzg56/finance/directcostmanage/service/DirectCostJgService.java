package com.xzg56.finance.directcostmanage.service;

import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.finance.directcostmanage.dao.DirectCostJgDao;
import com.xzg56.finance.directcostmanage.model.DirectCostJgModel;
import com.xzg56.utility.NumberUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wjn on 2017/6/6.
 */
@Service
@Transactional(readOnly = true)
public class DirectCostJgService extends BaseService {

    @Resource
    private DirectCostJgDao directCostJgDao;

    public List<DirectCostJgModel> getDirectCost(DirectCostJgModel directCostModel) {
        List<DirectCostJgModel> directList = directCostJgDao.getDirectCostList(directCostModel);
        return transformDict(directList);
    }

    private List<DirectCostJgModel> transformDict(List<DirectCostJgModel> directList) {

        //商务审批状态
        List<Dict> binsApprovalSts = DictUtils.getDictList("BINS_APPROVAL_STATUS");
        //往来单位类型
        List<Dict> relatedCompyType = DictUtils.getDictList("RELATED_COMPY_TYPE");
        //订单状态
        List<Dict> ordSts = DictUtils.getDictList("ORD_STS_CODE");
        //是否
        List<Dict> sysConfirm = DictUtils.getDictList("SYS_CONFIRM_FLAG");
        //费用状态
        List<Dict> feeStatus = DictUtils.getDictList("FEE_STATUS");
        //核销状态
        List<Dict> fiDoneSts = DictUtils.getDictList("FEE_FI_DONE_STATUS");
        //核销状态
        List<Dict> paymentType = DictUtils.getDictList("PAYMENT_TYPE");
        for (DirectCostJgModel model : directList) {
            for (Dict dict : binsApprovalSts) {
                if (StringUtils.equals(model.getBinsApprovalFlag(), dict.getValue())) {
                    model.setBinsApprovalName(dict.getLabel());
                    break;
                }
            }
            for (Dict dict : ordSts) {
                if (StringUtils.equals(model.getOrdSts(), dict.getValue())) {
                    model.setOrdSts(dict.getLabel());
                    break;
                }
            }

            for (Dict dict : relatedCompyType) {
                if (StringUtils.equals(model.getRelatedCompyType(), dict.getValue())) {
                    model.setRelatedCompyType(dict.getLabel());
                    break;
                }
            }
            for (Dict dict : feeStatus) {
                if (StringUtils.equals(model.getFeeStatus(), dict.getValue())) {
                    model.setFeeStatusName(dict.getLabel());
                    break;
                }
            }

            for (Dict dict : fiDoneSts) {
                if (StringUtils.equals(model.getFiDoneSts(), dict.getValue())) {
                    model.setFiDoneStsName(dict.getLabel());
                    break;
                }
            }

            for (Dict dict : sysConfirm) {
                if (StringUtils.equals(model.getInvoiceIssueNeedFlag(), dict.getValue())) {
                    model.setInvoiceIssueNeedName(dict.getLabel());
                    break;
                }
            }

            for (Dict dict : paymentType) {
                if (StringUtils.equals(model.getPaymentType(), dict.getValue())) {
                    model.setPaymentTypeName(dict.getLabel());
                    break;
                }
            }
        }

        return directList;
    }

    public Object getAmount(DirectCostJgModel directCostModel) {
        List<DirectCostJgModel> list = directCostJgDao.getAmount(directCostModel);
        BigDecimal rAmount = new BigDecimal("0");
        BigDecimal pAmount = new BigDecimal("0");
        BigDecimal rBillAmount = new BigDecimal("0");
        BigDecimal pBillAmount = new BigDecimal("0");
        BigDecimal rUnBillAmount = new BigDecimal("0");
        BigDecimal pUnBillAmount = new BigDecimal("0");
        for (DirectCostJgModel model : list) {
            if (BizFcConstants.PAYMENT_TYPE.RECEIVE.equals(model.getPaymentType())) {
                rAmount = rAmount.add(new BigDecimal(model.getAmount()));
                rBillAmount = rBillAmount.add(new BigDecimal(model.getBillAmount()));
            }
            if (BizFcConstants.PAYMENT_TYPE.PAY.equals(model.getPaymentType())) {
                pAmount = pAmount.add(new BigDecimal(model.getAmount()));
                pBillAmount = pBillAmount.add(new BigDecimal(model.getBillAmount()));
            }
        }
        rUnBillAmount = rAmount.subtract(rBillAmount);
        pUnBillAmount = pAmount.subtract(pBillAmount);
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rAmount", NumberUtils.formatDouble(rAmount.doubleValue()));
        map.put("pAmount",  NumberUtils.formatDouble(pAmount.doubleValue()));
        map.put("rBillAmount",  NumberUtils.formatDouble(rBillAmount.doubleValue()));
        map.put("pBillAmount",  NumberUtils.formatDouble(pBillAmount.doubleValue()));
        map.put("rUnBillAmount",  NumberUtils.formatDouble(rUnBillAmount.doubleValue()));
        map.put("pUnBillAmount",  NumberUtils.formatDouble(pUnBillAmount.doubleValue()));
        String json = JsonUtils.toString(map);
        return json;
    }
}
