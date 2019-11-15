package com.xzg56.jg.modules.api.gps.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.api.gps.model.CarGpsInfoDetailModel;
import com.xzg56.jg.modules.api.gps.model.DzkaGpsCanvarModel;
import com.xzg56.jg.modules.api.gps.model.GpsWsReasonModel;
import com.xzg56.jg.modules.api.gps.model.MstTrailerModel;
import org.apache.ibatis.annotations.Param;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by wellen on 2019/4/16.
 */

@MyBatisDao
public interface CarGpsInfoDao {
    CarGpsInfoDetailModel getCarGpsDailyKmByKey(CarGpsInfoDetailModel carGpsInfoDetailModel);
    Long insertGpsDailyKm(CarGpsInfoDetailModel carGpsInfoDetailModel);
    Long updateGpsDailyKm(CarGpsInfoDetailModel carGpsInfoDetailModel);
    Long insertGpsDailyKmResume(CarGpsInfoDetailModel carGpsInfoDetailModel);
    int updateTSysParameter(@Param("updateTime") String updateTime);
    void updateTSysP();
    List<MstTrailerModel> findMstTrailers();
    String findGpsPlateNumByPlateNum(@Param("plateNum") String plateNum);
    List<String> findGpsPlateNumList();
    List<DzkaGpsCanvarModel> getCarGpsCanvas(@Param("carPlateNum") String carPlateNum, @Param("beginTime") Timestamp beginTime, @Param("endTime") Timestamp endTime);
    void addGpsDailyReasonHis(GpsWsReasonModel model);
}
