package com.xzg56.jg.modules.container.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.common.model.ContainerModel;
import com.xzg56.jg.modules.container.model.PriceContractModel;
import com.xzg56.jg.modules.container.model.PriceContractSearchModel;
import com.xzg56.jg.modules.helper.model.HelperModel;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteModel;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteSearchModel;
import com.xzg56.jg.modules.mst.oilManagement.model.SelectModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface ContainerDao {
    //新增订单
    void addOrder(ContainerModel model);
    //查询订单
    List<ContainerModel> searchOrderList(ContainerModel model);
    //根据订单号查询订单信息
    ContainerModel searchOrder(@Param("orderNo") String orderNo);
    //修改订单信息
    void updateOrder(ContainerModel model);
    //查询车架号
    String searchFrameNum(@Param("id") String id);
    //查询司机
    ContainerModel getDriverCode(@Param("plateNum") String plateNum);
    //模糊查询箱号
    List<String> getLikeContnNos(@Param("contnNo") String contnNo);
    //查询箱号是mst_contn是否存在
    ContainerModel getContainerType(@Param("contnNo") String contnNo);

    List<ContainerModel> listOrdersByContnNo(@Param("contnNo") String contnNo, @Param("crossBoxTime") String crossBoxTime);

    void batchUpdateCrossBoxTimeByContnNo(@Param("contnNo") String contnNo, @Param("crossBoxTime") String crossBoxTime, @Param("oldCrossBoxTime") String oldCrossBoxTime, @Param("userId") String userId);

    void batchUpdateChangeBoxTimeByContnNo(@Param("contnNo") String contnNo, @Param("changeBoxTime") String changeBoxTime, @Param("oldChangeBoxTime") String oldChangeBoxTime, @Param("userId") String userId);

    String getCrossBoxTimeByContnNo(@Param("contnNo") String contnNo);

    ContainerModel getStdAdrsCodesByZxd(@Param("zxdId") String zxdId);

    List<HelperModel> getPriceContracts(@Param("cusCode") String cusCode);

    List<PriceContractModel> getPriceContractsByStdAddrs(PriceContractSearchModel searchModel);

    List<PriceContractModel> getPriceContractsByStdAddrsByIds(List<String> priceBfIds);

    // 上线后过渡期运费是否生成的控制，上线之前生成的订单都不做运费处理
    int countByCreateTime(@Param("orderNo") String orderNo,
                          @Param("limitTimeGroupno") String limitTimeGroupno,
                          @Param("dictValue") String dictValue);

    String getLinkUpTripOrder(@Param("contnNo") String contnNo, @Param("fromCountyCode") String fromCountyCode, @Param("toCountyCode") String toCountyCode);

    void updateLinkUpOrder(@Param("orderNo") String orderNo,
                           @Param("rCusBfPrice") double rCusBfPrice,
                           @Param("contaBfId") String contaBfId,
                           @Param("priceContract") String priceContract);

    List<SelectModel> listStdAddressesByCodes(List<String> codes);

    int countRoleWithoutDispatcher(@Param("userId") long userId);

    String getFuelPrice(@Param("departureDate") String departureDate);

    String getZxAdrsNameById(@Param("id") String id);

    Integer getOrdSpecialContnCount(@Param("contnNo") String contnNo);

    //相同箱子，最后一趟发车订单
    String lastDepartureDateOrder(@Param("contnNo") String contnNo);

    // 获取工资
    List<CostRouteModel> listCostRoutes(CostRouteSearchModel searchModel);

    List<CostRouteModel> listCostRoutesByIds(List<String> costRouteIds);
}
