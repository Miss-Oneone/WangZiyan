package com.xzg56.jg.modules.api.scheduletask.service;

import com.alibaba.fastjson.JSON;
import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.common.domain.IExpenseDomain;
import com.xzg56.jg.modules.common.model.ContainerModel;
import com.xzg56.jg.modules.common.persistence.entity.OrdExpenseTemporary;
import com.xzg56.utility.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by wellen on 2019/5/16.
 */

@Service
@Transactional(readOnly = true)
public class JobApiService extends BaseService {

    @Autowired
    private IExpenseDomain expenseDomain;

    /**
     * 费用生成（玖戈）
     * @param expenseTemp
     */
    @Transactional(readOnly = false)
    public void autoSubmitExpense(OrdExpenseTemporary expenseTemp) {
        ContainerModel containerModel = JSON.parseObject(expenseTemp.getParams(), ContainerModel.class);
        if (StringUtils.equals(PjConstants.ORD_EXPENSE_ACTION_TYPE.ADD, expenseTemp.getType())) {
            // 新增
            expenseDomain.createOrdReceipts(containerModel, containerModel.getOrderNo(), true);
            expenseDomain.createTripOilFee(containerModel);
            expenseDomain.createOrUpdateDrawingFee(containerModel);
            expenseDomain.createTireLossFee(containerModel);
            expenseDomain.createStdDrvSalPrice(containerModel);
        } else {
            // 编辑
            expenseDomain.updateOrdReceipts(containerModel, containerModel.getOrderNo());
            expenseDomain.updateTripOilFee(containerModel);
            expenseDomain.createOrUpdateDrawingFee(containerModel);
            expenseDomain.updateTireLossFee(containerModel);
            expenseDomain.updateStdDrvSalPrice(containerModel);
        }
    }

    /**
     * 获取未处理的费用队列（玖戈）
     * @return
     */
    public List<OrdExpenseTemporary> listOrdExpTempsForBatch() {
        return expenseDomain.getOrdExpenseTemporaryDao().listForBatch();
    }

    /**
     * 修改费用队列状态（玖戈）
     * @param expenseTemp
     */
    @Transactional(readOnly = false)
    public void updateOrdExpTempStatus(OrdExpenseTemporary expenseTemp) {
        expenseDomain.getOrdExpenseTemporaryDao().update(expenseTemp);
    }
}
