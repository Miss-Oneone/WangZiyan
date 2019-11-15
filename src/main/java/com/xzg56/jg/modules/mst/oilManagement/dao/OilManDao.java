package com.xzg56.jg.modules.mst.oilManagement.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.oilManagement.model.OilBalanceModel;
import com.xzg56.jg.modules.mst.oilManagement.model.OilBalanceSearchModel;
import com.xzg56.jg.modules.mst.oilManagement.model.SelectModel;

import java.util.List;

/**
 * Created by wellen on 2019/4/17.
 */

@MyBatisDao
public interface OilManDao {
    List<OilBalanceModel> listFuelFillings(OilBalanceSearchModel searchModel);
    List<OilBalanceModel> listFuelFillingBalanceGps(List<OilBalanceModel> oilBalanceModels);
    List<SelectModel> listDrivers();
    List<SelectModel> listTrailers();
}
