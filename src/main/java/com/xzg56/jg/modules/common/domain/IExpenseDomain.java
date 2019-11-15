package com.xzg56.jg.modules.common.domain;

import com.xzg56.finance.common.persistence.entity.OrdReceiptsPayments;
import com.xzg56.jg.modules.common.model.ContainerModel;
import com.xzg56.jg.modules.common.persistence.dao.CostRouteDao;
import com.xzg56.jg.modules.common.persistence.dao.OrdExpenseTemporaryDao;
import com.xzg56.jg.modules.common.persistence.entity.CostRoute;

import java.util.List;

/**
 * Created by wellen on 2019/5/16.
 */
public interface IExpenseDomain {

    /**
     * 注册订单费用队列
     * @param container
     * @param type 0:新增; 1:编辑
     */
    void registerOrdExpenseTemp(ContainerModel container, String type);

    /**
     * 生成趟次油费
     * @param container
     */
    void createTripOilFee(ContainerModel container);

    /**
     * 修改趟次油費
     * @param container
     */
    void updateTripOilFee(ContainerModel container);

    /**
     * 生成或修改抽成費（小杨啤酒）
     * @param container
     */
    void createOrUpdateDrawingFee(ContainerModel container);

    /**
     * 生成应收应付
     * @param orderNo
     * @param piCode
     * @param piName
     * @param paymentType
     * @param amount
     * @param expDate
     * @param compyCode
     * @param remarks
     */
    void createOrdRecPayment(String orderNo, String piCode, String piName, String paymentType, double amount, String expDate, String compyCode, String remarks);

    /**
     * 修改应收应付
     * @param receiptsPayments
     * @param orderNo
     * @param piCode
     * @param piName
     * @param paymentType
     * @param amount
     * @param expDate
     * @param compyCode
     * @param remarks
     */
    void updateOrdRecPayment(OrdReceiptsPayments receiptsPayments, String orderNo, String piCode, String piName, String paymentType, double amount, String expDate, String compyCode, String remarks);

    /**
     * 生成运费
     * @param container
     * @param orderNo 需要处理费用的订单号，由于双程为Y时，需要修改上行运费，所以这里做区分
     * @param hasResolveRoundTrip
     */
    void createOrdReceipts(ContainerModel container, String orderNo, boolean hasResolveRoundTrip);

    /**
     * 修改运费（系统生成的）
     * @param container
     * @param orderNo
     */
    void updateOrdReceipts(ContainerModel container, String orderNo);

    /**
     * 生成轮胎损耗
     * @param container
     */
    void createTireLossFee(ContainerModel container);

    /**
     * 修改轮胎损耗
     * @param container
     */
    void updateTireLossFee(ContainerModel container);

    OrdExpenseTemporaryDao getOrdExpenseTemporaryDao();

    /**
     * 批量生产应收应付
     * @param receiptsPayments
     */
    void batchCreateOrdRecPayment(List<OrdReceiptsPayments> receiptsPayments);

    void registerCostRoute(CostRoute costRoute);

    void updateCostRoute(CostRoute costRoute);

    CostRouteDao getCostRouteDao();

    /**
     * 生成司机工资
     * @param container
     */
    void createStdDrvSalPrice(ContainerModel container);

    /**
     * 修改司机工资
     * @param container
     */
    void updateStdDrvSalPrice(ContainerModel container);
}
