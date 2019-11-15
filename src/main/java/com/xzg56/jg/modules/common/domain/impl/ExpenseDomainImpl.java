package com.xzg56.jg.modules.common.domain.impl;

import com.alibaba.fastjson.JSONObject;
import com.xzg56.common.module.sys.basic.service.NumberingService;
import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.finance.common.persistence.dao.OrdReceiptsPaymentsDao;
import com.xzg56.finance.common.persistence.entity.OrdReceiptsPayments;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.common.domain.IExpenseDomain;
import com.xzg56.jg.modules.common.model.ContainerModel;
import com.xzg56.jg.modules.common.persistence.dao.CostRouteDao;
import com.xzg56.jg.modules.common.persistence.dao.OrdExpenseTemporaryDao;
import com.xzg56.jg.modules.common.persistence.entity.CostRoute;
import com.xzg56.jg.modules.common.persistence.entity.OrdExpenseTemporary;
import com.xzg56.jg.modules.container.dao.ContainerDao;
import com.xzg56.jg.modules.container.model.PriceContractModel;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.NumberUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wellen on 2019/5/16.
 */

@Component
public class ExpenseDomainImpl implements IExpenseDomain {

    @Resource
    private OrdReceiptsPaymentsDao ordReceiptsPaymentsDao;

    @Resource
    private OrdExpenseTemporaryDao ordExpenseTemporaryDao;

    @Resource
    private ContainerDao containerDao;

    @Resource
    private CostRouteDao costRouteDao;

    @Resource
    private NumberingService numberingService;

    @Override
    public void registerOrdExpenseTemp(ContainerModel container, String type) {
        OrdExpenseTemporary expenseTemporary = new OrdExpenseTemporary();
        String batchId = numberingService.getNumber(NumberingService.NUMBER_CODE.ORD_EXPENSE_TEMP_NO, NumberingService.EMPTY_PRE);
        JSONObject paramsJson = (JSONObject) JSONObject.toJSON(container);
        expenseTemporary.setBatchId(batchId);
        expenseTemporary.setType(type);
        expenseTemporary.setStatus(PjConstants.QUEUE_STATUS.WAITING);
        expenseTemporary.setCount(0);
        expenseTemporary.setParams(paramsJson.toString());
        ordExpenseTemporaryDao.insert(expenseTemporary);
    }

    /**
     * 生成运费
     *
     * @param container
     */
    @Override
    public void createOrdReceipts(ContainerModel container, String orderNo, boolean hasResolveRoundTrip) {
        // 上线过度时期控制,上线之前生成的订单都不做运费处理
        int cnt = containerDao.countByCreateTime(orderNo, "PRICE_CONTRACT_TEMP_TIME", null);
        if (cnt == 0) {
            return;
        }
        // 运费为0不生成费用
        if (StringUtils.isNotBlank(container.getrCusBfPrice()) && container.getrCusBfPrice() > 0d) {
            createOrdRecPayment(orderNo, PjConstants.PI_YF, PjConstants.PI_YF_NAME, PjConstants.PAYMENT_TYPE.REC, container.getrCusBfPrice(),
                    DateUtils.getFormatDate("yyyy-MM-28", 2), container.getCusCode(), null);
            // 如果有超重费，同样生成费用
            if (container.getOverweightPrice() > 0d) {
                createOverweightPrice(container, orderNo);
            }
            // 如果是双程运费，需要修改之前上行的运费为当前运费
            if (StringUtils.equals(container.getRoundTripFlag(), PjConstants.FLAG_Y) && hasResolveRoundTrip) {
                autoUpdateUpTripOrderPrice(container);
            }
        }
    }

    /**
     * 修改运费（系统生成的）
     *
     * @param container
     */
    @Override
    public void updateOrdReceipts(ContainerModel container, String orderNo) {
        // 上线过度时期控制,上线之前生成的订单都不做运费处理
        int cnt = containerDao.countByCreateTime(orderNo, "PRICE_CONTRACT_TEMP_TIME", null);
        if (cnt == 0) {
            return;
        }
        // 修改之前订单费用
        List<OrdReceiptsPayments> receipts = ordReceiptsPaymentsDao.listByOrderNo(orderNo, PjConstants.FLAG_Y, PjConstants.PI_YF, BizFcConstants.SPACE);
        for (OrdReceiptsPayments receipt : receipts) {
            // 运费（如果订单号不同，说明是双程费用修改上行的订单）
            if (StringUtils.equals(receipt.getPiCode(), PjConstants.PI_YF)) {
                // 如果当前没有运费或运费为0，直接删除订单系统生成的费用，如果有则修改
                if (container.getrCusBfPrice() > 0d) {
                    updateOrdRecPayment(receipt, orderNo, PjConstants.PI_YF, PjConstants.PI_YF_NAME, PjConstants.PAYMENT_TYPE.REC, container.getrCusBfPrice(),
                            DateUtils.getFormatDate("yyyy-MM-28", 2), container.getCusCode(), null);
                    // 如果修改为双程价格，自动修改之前上行订单运价（防止死循环，用订单号是否相同作为执行条件）
                    if (StringUtils.equals(container.getRoundTripFlag(), PjConstants.FLAG_Y) && StringUtils.equals(container.getOrderNo(), orderNo)) {
                        autoUpdateUpTripOrderPrice(container);
                    }
                } else {
                    ordReceiptsPaymentsDao.delete(receipt);
                }
            }
            // 超重费（如果订单号不同，说明是双程费用修改上行的订单，这时超重费不用去修改）
            if (StringUtils.equals(receipt.getPiCode(), PjConstants.PI_CZF) && StringUtils.equals(container.getOrderNo(), orderNo)) {
                // 如果当前没有超重费了，直接删除；如果有则修改
                if (container.getOverweightPrice() > 0d) {
                    String remarks = transformOverweightPriceRemarks(container);
                    updateOrdRecPayment(receipt, orderNo, PjConstants.PI_CZF, PjConstants.PI_CZF_NAME, PjConstants.PAYMENT_TYPE.REC, container.getOverweightPrice(),
                            DateUtils.getFormatDate("yyyy-MM-28", 2), container.getCusCode(), remarks);
                } else {
                    ordReceiptsPaymentsDao.delete(receipt);
                }
            }
        }
        // 如果订单号不同，说明是双程费用修改上行的订单，这时超重费不用去修改
        if (!StringUtils.equals(container.getOrderNo(), orderNo)) {
            return;
        }
        // 如果之前没有费用，直接创建费用
        if (receipts.size() < 1) {
            createOrdReceipts(container, orderNo, false);
        }
        // 如果之前没有超重费，现在有了，则添加一条超重费
        if (receipts.size() < 2 && container.getOverweightPrice() > 0d) {
            createOverweightPrice(container, orderNo);
        }
    }

    /**
     * 生成趟次油费
     * 1.根据起始地、到达地四级地址
     * 2.长途只有上行才生成，短途都生成
     * 3.只有自有和挂靠才生产
     * 4.长途车开长途--补给司机；长途车开短途--不生成（暂不确定）；短途车开短途--补给公司；短途车不会开长途（4作废）
     * 5.计算公式：核定公里数*百公里油耗/100*油价
     * 6.如果客户是小杨啤酒，另外生成一条200元应付（抽成）
     *
     * @param container
     */
    @Override
    public void createTripOilFee(ContainerModel container) {
        // 上线过度时期控制,上线之前生成的订单都不做费用处理
        int cnt = containerDao.countByCreateTime(container.getOrderNo(), "FEE_LIMIT_TIME", "0");
        if (cnt == 0) {
            return;
        }

        if (StringUtils.isNotBlank(container.getLiters()) &&
                (StringUtils.equals(container.getTripFlag(), Constants.TRIP_FLAG_UP) && StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.LONG) ||
                        StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.SHORT)) &&
                StringUtils.isNotBlank(container.getPlateNum()) &&
                (StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OWN) ||
                        StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.ATTACH))) {

            String relatedCompyCode = getTripOilFeeRelatedCompy(container);
            if (StringUtils.isNotBlank(relatedCompyCode)) {
                // 计算油补费
                double amount = computeTripOilFee(container);
                if (amount > 0d) {
                    String remarks = transformTripOilFeeRemarks(container);
                    createOrdRecPayment(container.getOrderNo(), PjConstants.PI_TCYF, PjConstants.PI_TCYF_NAME, PjConstants.PAYMENT_TYPE.PAY,
                            amount, DateUtils.getFormatDate("yyyy-MM-25", 1), relatedCompyCode, remarks);
                }
            }
        }
    }

    /**
     * 修改趟次油费
     *
     * @param container
     */
    @Override
    public void updateTripOilFee(ContainerModel container) {
        // 上线过度时期控制,上线之前生成的订单都不做费用处理
        int cnt = containerDao.countByCreateTime(container.getOrderNo(), "FEE_LIMIT_TIME", "0");
        if (cnt == 0) {
            return;
        }
        boolean isGenerate = StringUtils.isNotBlank(container.getLiters()) &&
                (StringUtils.equals(container.getTripFlag(), Constants.TRIP_FLAG_UP) && StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.LONG) ||
                        StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.SHORT)) &&
                StringUtils.isNotBlank(container.getPlateNum()) &&
                (StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OWN) ||
                        StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.ATTACH));

        String relatedCompnCode = getTripOilFeeRelatedCompy(container);
        double amount = computeTripOilFee(container);
        String remarks = transformTripOilFeeRemarks(container);

        updateCommonPayment(container.getOrderNo(), PjConstants.PI_TCYF, PjConstants.PI_TCYF_NAME, isGenerate, relatedCompnCode, amount, remarks);
    }

    /**
     * 抽成费
     * 客户是小杨啤酒，即生成一笔应付给杨小姐
     *
     * @param container
     */
    @Override
    public void createOrUpdateDrawingFee(ContainerModel container) {
        // 上线过度时期控制,上线之前生成的订单都不做费用处理
        int cnt = containerDao.countByCreateTime(container.getOrderNo(), "FEE_LIMIT_TIME", "0");
        if (cnt == 0) {
            return;
        }
        List<OrdReceiptsPayments> receipts = ordReceiptsPaymentsDao.listByOrderNo(container.getOrderNo(), PjConstants.FLAG_Y, PjConstants.PI_CCF, BizFcConstants.SPACE);
        if (StringUtils.equals(Constants.XYPJ_COMPY_CODE, container.getCusCode())) {
            // 查询抽成费金额
            List<Dict> dicts = DictUtils.getDictList("YANG_PI_CCF");
            double drawingFee = PjConstants.YANG_PI_CCF;
            if (dicts.size() > 0) {
                drawingFee = StringUtils.toDouble(dicts.get(0).getValue());
            }

            if (receipts.size() == 0) {
                // 新增
                createOrdRecPayment(container.getOrderNo(), PjConstants.PI_CCF, PjConstants.PI_CCF_NAME, PjConstants.PAYMENT_TYPE.PAY, drawingFee,
                        DateUtils.getFormatDate("yyyy-MM-25", 1), Constants.YANG_COMPY_CODE, null);
            } else {
                // 修改
                boolean existsFee = false;
                for (OrdReceiptsPayments receipt : receipts) {
                    if (StringUtils.equals(Constants.YANG_COMPY_CODE, receipt.getCompyCode())) {
                        existsFee = true;
                        break;
                    }
                }
                if (!existsFee) {
                    createOrdRecPayment(container.getOrderNo(), PjConstants.PI_CCF, PjConstants.PI_CCF_NAME, PjConstants.PAYMENT_TYPE.PAY, drawingFee,
                            DateUtils.getFormatDate("yyyy-MM-25", 1), Constants.YANG_COMPY_CODE, null);
                }
            }
        } else {
            deleteOrdReceiptsPayments(receipts);
        }
    }

    /**
     * 生成应收应付
     *
     * @param orderNo
     * @param piCode
     * @param piName
     * @param paymentType
     * @param amount
     * @param expDate
     * @param compyCode
     * @param remarks
     */
    @Override
    public void createOrdRecPayment(String orderNo, String piCode, String piName, String paymentType, double amount, String expDate, String compyCode, String remarks) {
        OrdReceiptsPayments receiptsPayments = new OrdReceiptsPayments();
        receiptsPayments.setOrderNo(orderNo);
        receiptsPayments.setPiCode(piCode);
        receiptsPayments.setPiName(piName);
        receiptsPayments.setActiveFlag(PjConstants.FLAG_Y);
        receiptsPayments.setEditableFlag(PjConstants.FLAG_N);
        receiptsPayments.setPaymentType(paymentType);
        receiptsPayments.setFeeType(PjConstants.FEE_TYPE.DIRECT);
        receiptsPayments.setAmount(amount);
        receiptsPayments.setExpDate(expDate);
        receiptsPayments.setCompyCode(compyCode);
        receiptsPayments.setSystemAutoFlag(PjConstants.FLAG_Y);
        receiptsPayments.setFeeStatus(PjConstants.FEE_STATUS_1);
        receiptsPayments.setRemarks(remarks);
        ordReceiptsPaymentsDao.insert(receiptsPayments);
    }

    /**
     * 修改应收应付
     *
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
    @Override
    public void updateOrdRecPayment(OrdReceiptsPayments receiptsPayments, String orderNo, String piCode, String piName, String paymentType, double amount, String expDate, String compyCode, String remarks) {
        receiptsPayments.setOrderNo(orderNo);
        receiptsPayments.setPiCode(piCode);
        receiptsPayments.setPiName(piName);
        receiptsPayments.setActiveFlag(PjConstants.FLAG_Y);
        receiptsPayments.setEditableFlag(PjConstants.FLAG_N);
        receiptsPayments.setPaymentType(paymentType);
        receiptsPayments.setFeeType(PjConstants.FEE_TYPE.DIRECT);
        receiptsPayments.setAmount(amount);
        receiptsPayments.setExpDate(expDate);
        receiptsPayments.setCompyCode(compyCode);
        receiptsPayments.setSystemAutoFlag(PjConstants.FLAG_Y);
        receiptsPayments.setFeeStatus(PjConstants.FEE_STATUS_1);
        receiptsPayments.setRemarks(remarks);
        ordReceiptsPaymentsDao.update(receiptsPayments);
    }

    @Override
    public OrdExpenseTemporaryDao getOrdExpenseTemporaryDao() {
        return ordExpenseTemporaryDao;
    }

    /**
     * 生成轮胎损耗
     * 每个订单除了一下条件外都生成
     * 1.外排车：需要等派车后才能生知道（根据判断是否有车牌）
     *
     * @param container
     */
    @Override
    public void createTireLossFee(ContainerModel container) {
        // 上线过度时期控制,上线之前生成的订单都不做费用处理
        int cnt = containerDao.countByCreateTime(container.getOrderNo(), "FEE_LIMIT_TIME", "0");
        if (cnt == 0) {
            return;
        }
        if (StringUtils.isNotBlank(container.getAdjKmStr()) && StringUtils.isNotBlank(container.getPlateNum()) &&
                !StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OUTER)) {
            // 查询轮胎损耗系数
            List<Dict> dicts = DictUtils.getDictList("PI_LTSH_COEFFICIENT");
            if (dicts.size() == 0) {
                throw new ValidationException("处理轮胎损耗费用失败：缺少轮胎损耗系数");
            }

            double coefficient = StringUtils.toDouble(dicts.get(0).getValue());
            double tireLossFee = new BigDecimal(container.getAdjKmStr()).multiply(new BigDecimal(coefficient)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            String remarks = transformTireLossFeeRemarks(container, coefficient);
            if (tireLossFee > 0d) {
                createOrdRecPayment(container.getOrderNo(), PjConstants.PI_LTSH, PjConstants.PI_LTSH_NAME, PjConstants.PAYMENT_TYPE.PAY,
                        tireLossFee, DateUtils.getFormatDate("yyyy-MM-25", 1), Constants.JG_COMPY_CODE, remarks);
            }
        }
    }

    /**
     * 修改轮胎损耗
     *
     * @param container
     */
    @Override
    public void updateTireLossFee(ContainerModel container) {
        // 上线过度时期控制,上线之前生成的订单都不做费用处理
        int cnt = containerDao.countByCreateTime(container.getOrderNo(), "FEE_LIMIT_TIME", "0");
        if (cnt == 0) {
            return;
        }
        boolean isGenerate = StringUtils.isNotBlank(container.getAdjKmStr()) && StringUtils.isNotBlank(container.getPlateNum()) &&
                !StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OUTER);

        // 查询轮胎损耗系数
        List<Dict> dicts = DictUtils.getDictList("PI_LTSH_COEFFICIENT");
        if (dicts.size() == 0) {
            throw new ValidationException("处理轮胎损耗费用失败：缺少轮胎损耗系数");
        }

        double coefficient = StringUtils.toDouble(dicts.get(0).getValue());
        double tireLossFee = 0d;
        if (StringUtils.isNotBlank(container.getAdjKmStr())) {
            tireLossFee = new BigDecimal(container.getAdjKmStr()).multiply(new BigDecimal(coefficient)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        }
        String remarks = transformTireLossFeeRemarks(container, coefficient);

        updateCommonPayment(container.getOrderNo(), PjConstants.PI_LTSH, PjConstants.PI_LTSH_NAME, isGenerate, Constants.JG_COMPY_CODE, tireLossFee, remarks);
    }

    /**
     * 批量录入应收应付
     *
     * @param receiptsPayments
     */
    @Override
    public void batchCreateOrdRecPayment(List<OrdReceiptsPayments> receiptsPayments) {
        ordReceiptsPaymentsDao.batchCreateOrdRecPayment(receiptsPayments);
    }

    @Override
    public void registerCostRoute(CostRoute costRoute) {
        costRouteDao.insert(costRoute);
    }

    @Override
    public void updateCostRoute(CostRoute costRoute) {
        costRouteDao.update(costRoute);
    }

    @Override
    public CostRouteDao getCostRouteDao() {
        return costRouteDao;
    }

    /**
     * 生成司机工资
     * 1.已派车
     * 2.长途上行才生成；短途都生成
     * 3.外排叫戈享运费，不考虑上下行
     *
     * @param container
     */
    @Override
    public void createStdDrvSalPrice(ContainerModel container) {
        // 上线过度时期控制,上线之前生成的订单都不做费用处理
        int cnt = containerDao.countByCreateTime(container.getOrderNo(), "FEE_LIMIT_TIME", "1");
        if (cnt == 0) {
            return;
        }
        if (StringUtils.isNotBlank(container.getStdDrvSalPrice()) &&
                StringUtils.toDouble(container.getStdDrvSalPrice()) > 0d &&
                StringUtils.isNotBlank(container.getDriverCode()) &&
                ((!StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OUTER) &&
                        ((StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.LONG) &&
                                StringUtils.equals(container.getTripFlag(), Constants.TRIP_FLAG_UP)) ||
                                StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.SHORT))) ||
                        StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OUTER))) {

            specRouteDrvSalTempFunc(container);
            String piCode = PjConstants.PI_SJGZ;
            String piName = PjConstants.PI_SJGZ_NAME;
            if (StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OUTER)) {
                piCode = PjConstants.PI_GXYF;
                piName = PjConstants.PI_GXYF_NAME;
            }
            createOrdRecPayment(container.getOrderNo(), piCode, piName, PjConstants.PAYMENT_TYPE.PAY, StringUtils.toDouble(container.getStdDrvSalPrice()),
                    DateUtils.getFormatDate("yyyy-MM-25", 1), container.getDriverCode(), null);
        }
    }

    /**
     * 修改司机工资
     *
     * @param container
     */
    @Override
    public void updateStdDrvSalPrice(ContainerModel container) {
        // 上线过度时期控制,上线之前生成的订单都不做费用处理
        int cnt = containerDao.countByCreateTime(container.getOrderNo(), "FEE_LIMIT_TIME", "1");
        if (cnt == 0) {
            return;
        }
        boolean isGenerate = StringUtils.isNotBlank(container.getStdDrvSalPrice()) &&
                StringUtils.toDouble(container.getStdDrvSalPrice()) > 0d &&
                StringUtils.isNotBlank(container.getDriverCode()) &&
                ((!StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OUTER) &&
                        ((StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.LONG) &&
                                StringUtils.equals(container.getTripFlag(), Constants.TRIP_FLAG_UP)) ||
                                StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.SHORT))) ||
                        StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OUTER));

        double amount = 0d;
        if (StringUtils.isNotBlank(container.getStdDrvSalPrice())) {
            specRouteDrvSalTempFunc(container);
            amount = StringUtils.toDouble(container.getStdDrvSalPrice());
        }
        String piCode = PjConstants.PI_SJGZ;
        String piName = PjConstants.PI_SJGZ_NAME;
        if (StringUtils.equals(container.getTrailerBelongType(), Constants.TRAILER_BELONG_TYPE.OUTER)) {
            piCode = PjConstants.PI_GXYF;
            piName = PjConstants.PI_GXYF_NAME;
        }
        updateCommonPayment(container.getOrderNo(), piCode, piName, isGenerate, container.getDriverCode(), amount, null);
    }

    /**
     * 自动修改上行订单价格
     *
     * @param container
     */
    private void autoUpdateUpTripOrderPrice(ContainerModel container) {
        // 根据箱号、上行标志、最邻近的时间、当前订单到达地四级地址为起运地四级地址，查找对应上行订单
        String linkOrderNo = containerDao.getLinkUpTripOrder(container.getContnNo(), container.getFromCountyCode(), container.getToCountyCode());
        if (StringUtils.isNotBlank(linkOrderNo)) {
            updateOrdReceipts(container, linkOrderNo);
            // 修改对应订单的价格冗余字段
            containerDao.updateLinkUpOrder(linkOrderNo, container.getrCusBfPrice(),
                    container.getContaBfId(), container.getPriceContract());
        }
    }

    /**
     * 生成超重费
     *
     * @param container
     */
    private void createOverweightPrice(ContainerModel container, String orderNo) {
        String remarks = transformOverweightPriceRemarks(container);
        createOrdRecPayment(orderNo, PjConstants.PI_CZF, PjConstants.PI_CZF_NAME, PjConstants.PAYMENT_TYPE.REC, container.getOverweightPrice(),
                DateUtils.getFormatDate("yyyy-MM-28", 2), container.getCusCode(), remarks);
    }

    /**
     * 超重备注
     *
     * @param container
     * @return
     */
    private String transformOverweightPriceRemarks(ContainerModel container) {
        StringBuffer buffer = new StringBuffer();
        if (StringUtils.isNotBlank(container.getContaBfId())) {
            List<String> contaBfIds = new ArrayList<>();
            contaBfIds.add(container.getContaBfId());
            List<PriceContractModel> priceContractModels = containerDao.getPriceContractsByStdAddrsByIds(contaBfIds);
            if (priceContractModels.size() > 0) {
                PriceContractModel priceContract = priceContractModels.get(0);
                double weight = container.getWeight();
                double limitWeight = StringUtils.isNotBlank(priceContract.getLimitWeight()) ? StringUtils.toDouble(priceContract.getLimitWeight()) : 0d;
                double overweightPrice = StringUtils.isNotBlank(priceContract.getOverweightPrice()) ? StringUtils.toDouble(priceContract.getOverweightPrice()) : 0d;

                buffer.append("超重").append(NumberUtils.format(weight - limitWeight)).append("吨；").append("超重部分按").append(overweightPrice).append("（元/吨）计算；")
                        .append("超重费：").append("(").append(weight).append(" - ").append(limitWeight).append(") * ").append(overweightPrice).append(" = ").append(container.getOverweightPrice()).append("（元）");
            }
        }

        return buffer.toString();
    }

    /**
     * 趟次油费备注
     * 核定公里数*百公里油耗/100*油价
     *
     * @param container
     * @return
     */
    private String transformTripOilFeeRemarks(ContainerModel container) {
        if (StringUtils.isBlank(container.getAdjKmStr()) || StringUtils.isBlank(container.getFuelPriceStr()) || StringUtils.isBlank(container.getLiters())) {
            return null;
        }
        StringBuffer buffer = new StringBuffer();
        buffer.append("(核定公里数)").append(container.getAdjKmStr()).append(" * (百公里油耗)").append(container.getLiters()).append(" / 100 * (油价)").append(container.getFuelPriceStr());

        return buffer.toString();
    }

    /**
     * 轮胎损耗备注
     * 核定公里数 * 损耗系数
     *
     * @param container
     * @return
     */
    private String transformTireLossFeeRemarks(ContainerModel container, double coefficient) {
        if (StringUtils.isBlank(container.getAdjKmStr())) {
            return null;
        }
        StringBuffer buffer = new StringBuffer();
        buffer.append("(核定公里数)").append(container.getAdjKmStr()).append(" * (损耗系数)").append(coefficient);

        return buffer.toString();
    }

    /**
     * 计算趟次油费
     *
     * @param container
     * @return
     */
    private double computeTripOilFee(ContainerModel container) {
        if (StringUtils.isBlank(container.getAdjKmStr()) || StringUtils.isBlank(container.getFuelPriceStr()) || StringUtils.isBlank(container.getLiters())) {
            return 0d;
        }
        BigDecimal adjKm = new BigDecimal(container.getAdjKmStr());
        BigDecimal liters = new BigDecimal(container.getLiters());
        BigDecimal fuelPrice = new BigDecimal(container.getFuelPriceStr());
        return adjKm.multiply(liters).multiply(fuelPrice).divide(new BigDecimal("100"), 2, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * 获取趟次油费往来单位
     *
     * @param container
     * @return
     */
    private String getTripOilFeeRelatedCompy(ContainerModel container) {
//        String relatedCompyCode = null;
//        if (StringUtils.equals(container.getTrailerTransportType(), Constants.TRANSPORT_TYPE.LONG) &&
//                StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.LONG)) {
//            // 长途车开长途
//            relatedCompyCode = container.getDriverCode();
//
//        } else if (StringUtils.equals(container.getTrailerTransportType(), Constants.TRANSPORT_TYPE.SHORT) &&
//                StringUtils.equals(container.getTransportType(), Constants.TRANSPORT_TYPE.SHORT)) {
//            // 短途车开短途
//            relatedCompyCode = Constants.JG_COMPY_CODE;
//        }
//
//        return relatedCompyCode;
        /** 临时改定，暂时存玖戈 **/
        return Constants.JG_COMPY_CODE;
    }

    /**
     * 删除应收应付
     *
     * @param receipts
     */
    private void deleteOrdReceiptsPayments(List<OrdReceiptsPayments> receipts) {
        for (OrdReceiptsPayments receipt : receipts) {
            ordReceiptsPaymentsDao.delete(receipt);
        }
    }

    /**
     * 修改应付费用共通方法
     *
     * @param orderNo
     * @param piCode
     * @param piName
     * @param isGenerate
     * @param relatedCompyCode
     * @param amount
     */
    private void updateCommonPayment(String orderNo, String piCode, String piName, boolean isGenerate, String relatedCompyCode, double amount, String remarks) {
        List<OrdReceiptsPayments> receiptsPayments = ordReceiptsPaymentsDao.listByOrderNo(orderNo, PjConstants.FLAG_Y, piCode, BizFcConstants.SPACE);
        // 司机工资根据运力类型会有两个价目，这边处理防止编辑时，修改运力类型后，之前旧的费用没有删除
        if (receiptsPayments.size() == 0 && StringUtils.equals(piCode, PjConstants.PI_SJGZ)) {
            receiptsPayments = ordReceiptsPaymentsDao.listByOrderNo(orderNo, PjConstants.FLAG_Y, PjConstants.PI_GXYF, BizFcConstants.SPACE);
        } else if (receiptsPayments.size() == 0 && StringUtils.equals(piCode, PjConstants.PI_GXYF)) {
            receiptsPayments = ordReceiptsPaymentsDao.listByOrderNo(orderNo, PjConstants.FLAG_Y, PjConstants.PI_SJGZ, BizFcConstants.SPACE);
        }
        if (isGenerate) {
            if (receiptsPayments.size() == 0 && StringUtils.isNotBlank(relatedCompyCode) && amount > 0d) {
                // 之前没有费用，现在要有，则直接生成
                createOrdRecPayment(orderNo, piCode, piName, PjConstants.PAYMENT_TYPE.PAY,
                        amount, DateUtils.getFormatDate("yyyy-MM-25", 1), relatedCompyCode, remarks);
            } else {
                // 之前有费用，编辑
                if (StringUtils.isBlank(relatedCompyCode) || amount <= 0d) {
                    deleteOrdReceiptsPayments(receiptsPayments);
                    return;
                }
                for (OrdReceiptsPayments receipt : receiptsPayments) {
                    // todo 暂不考虑费用状态
                    receipt.setCompyCode(relatedCompyCode);
                    receipt.setAmount(amount);
                    receipt.setRemarks(remarks);
                    ordReceiptsPaymentsDao.update(receipt);
                }
            }
        } else if (receiptsPayments.size() > 0) {
            // 删除之前的费用
            deleteOrdReceiptsPayments(receiptsPayments);
        }
    }

    /**
     * 特殊路线工资临时逻辑处理
     * 注（临时控制）：
     * 1.胶板，海沧到福清宏路街道 360元
     * 2.空上，海沧到福清宏路街道 300元
     *
     * @param container
     */
    private void specRouteDrvSalTempFunc(ContainerModel container) {
        if ((StringUtils.equals("350205001", container.getFromCountyCode()) || StringUtils.equals("350205001#", container.getFromCountyCode()))
                && StringUtils.equals("350181005", container.getToCountyCode())) {
            List<Dict> dicts = DictUtils.getDictList("SPEC_ROUTE_TEMP_DRV_SAL_PRICE");
            if (dicts != null && dicts.size() > 0) {
                for (Dict dict : dicts) {
                    if (StringUtils.equals(dict.getLabel(), container.getGoodsCodeIn())) {
                        container.setStdDrvSalPrice(dict.getValue());
                        break;
                    }
                }
            }
        }
    }
}
