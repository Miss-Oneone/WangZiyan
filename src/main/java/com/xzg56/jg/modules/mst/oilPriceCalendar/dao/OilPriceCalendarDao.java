package com.xzg56.jg.modules.mst.oilPriceCalendar.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.mst.oilPriceCalendar.model.OilPriceCalendarModel;
import com.xzg56.jg.modules.mst.oilPriceCalendar.model.OilPriceCalendarSearchModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by zxp on 2019/4/22.
 */
@MyBatisDao
public interface OilPriceCalendarDao extends BaseDao {

    List<OilPriceCalendarModel> searchOilPriceList(OilPriceCalendarSearchModel searchModel);
    String searchAvgPrice(@Param("searchDate") String searchDate);
    OilPriceCalendarModel getOilPrice(OilPriceCalendarModel addModel);
    void insertOilPrice(OilPriceCalendarModel addModel);
    void updateOilPrice(OilPriceCalendarModel addModel);
    void approvalOilPrice(OilPriceCalendarModel addModel);
    void delOilPrice(OilPriceCalendarModel addModel);
    int countDriverSalary(@Param("yearMonth") String yearMonth);
}
