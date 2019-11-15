package com.xzg56.finance.binsApprovalOrd.service;

import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.service.BaseService;
import com.xzg56.finance.binsApprovalOrd.dao.BinsApprovalOrdJgDao;
import com.xzg56.finance.binsApprovalOrd.model.*;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.utility.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.util.List;

@Service
@Transactional(readOnly = true)
public class BinsApprovalOrdJgService extends BaseService {

    @Resource
    BinsApprovalOrdJgDao binsApprovalOrdJgDao;

    public List<BinsApprovalOrdJgModel> find(BinsApprovalOrdJg binsApprovalOrdJg) {
        List<Dict> binsApprovalStatusList = DictUtils.getDictList(BizFcConstants.GROUP_NO.BINS_APPROVAL_STATUS);
        List<BinsApprovalOrdJgModel> list = binsApprovalOrdJgDao.find(binsApprovalOrdJg);
        for (BinsApprovalOrdJgModel model : list) {

            for (Dict dict : binsApprovalStatusList) {
                if (StringUtils.equals(dict.getValue(), model.getBinsApprovalFlag())) {
                    model.setBinsApprovalFlag(dict.getLabel());
                }
            }

            String remarks = "";
            boolean flag = true;
            String[] strList = StringUtils.split(model.getRemarks(), ',');
            for (int i = 0; i < strList.length; i++) {
                if (!StringUtils.isBlank(strList[i])) {
                    if (!flag) {
                        remarks = remarks + "," + strList[i];
                    } else {
                        remarks = remarks + strList[i];
                        flag = false;
                    }
                }
            }
            model.setRemarks(remarks);

            DecimalFormat df = new DecimalFormat("#.##%");
            Double profitRate = NumberUtils.toDouble(model.getProfit())/model.getrAmountSum();
            if(model.getrAmountSum()==0) {
                profitRate = 0.00;
            }
            model.setProfitRate(df.format(profitRate));

        }
        return list;

    }
}
