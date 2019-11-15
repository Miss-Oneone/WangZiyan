package com.xzg56.jg.modules.mst.oilManagement.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.constant.ApiConstant;
import com.xzg56.jg.modules.mst.oilManagement.dao.OilManDao;
import com.xzg56.jg.modules.mst.oilManagement.model.OilBalanceModel;
import com.xzg56.jg.modules.mst.oilManagement.model.OilBalanceSearchModel;
import com.xzg56.jg.modules.mst.oilManagement.model.SelectModel;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.HttpUtils;
import com.xzg56.utility.StringUtils;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by wellen on 2019/4/17.
 */

@Service
@Transactional(readOnly = true)
public class OilManService extends BaseService {

    @Resource
    private OilManDao oilManDao;

    public List<OilBalanceModel> listOilBalances(OilBalanceSearchModel searchModel) {
        // 查询加油信息
        List<OilBalanceModel> fuelFillings = oilManDao.listFuelFillings(searchModel);
        // 处理每次加油用油GPS公里数时间节点
        Map<String, String> fuelMap = new HashedMap();
        List<String> plateNums = new ArrayList<>();
        for (OilBalanceModel fuelFilling : fuelFillings) {
            String plateNum = fuelFilling.getPlateNum();
            if (!fuelMap.containsKey(plateNum)) {
                fuelMap.put(plateNum, fuelFilling.getGpsBeginDate());
                plateNums.add(fuelFilling.getPlateNum());
            } else {
                fuelFilling.setGpsEndDate(fuelMap.get(plateNum));
                fuelMap.put(plateNum, fuelFilling.getGpsBeginDate());
            }
        }
        // 查询每个车辆总时间节点GPS日里程
        List<OilBalanceModel> carsDailyKms = new ArrayList<>();
        Map<String, String> params = new HashedMap();
        params.put("fromTime", searchModel.getDateFrom());
        params.put("toTime", searchModel.getDateTo());
        params.put("plateNums", StringUtils.join(plateNums));
        params.put("compyCode", ApiConstant.GPS_COMPY_CODE);
        String result = HttpUtils.post(ApiConstant.GPS_INTERFACE.MANY_CAR_G_D_K, params, ApiConstant.GPS_SERVICE_APIKEY);
        JSONObject resJson = JSON.parseObject(result);
        if (!StringUtils.equals(resJson.getString("code"), ApiConstant.API_RESULT_STATUS.SUCCESS)) {
            logger.error("GPS日里程获取失败:" +  resJson.getString("msg"));
        } else if (StringUtils.isNotBlank(resJson.getString("data"))) {
            carsDailyKms = JSON.parseArray(resJson.getString("data"), OilBalanceModel.class);
        }
        // 计算每辆车，每次加油间隔时间里的公里数和
        for (OilBalanceModel fuelFilling : fuelFillings) {
            BigDecimal mileSum = BigDecimal.ZERO;
            for (OilBalanceModel carDailyKm : carsDailyKms) {
                if (StringUtils.equals(fuelFilling.getPlateNum(), carDailyKm.getPlateNum())) {
                    Date beginTime = DateUtils.parseDate(carDailyKm.getBeginTime());
                    Date gpsBeginDate = DateUtils.parseDate(fuelFilling.getGpsBeginDate());
                    Date gpsEndDate = DateUtils.parseDate(fuelFilling.getGpsEndDate());
                    if (gpsEndDate != null && beginTime.compareTo(gpsBeginDate) >= 0 && beginTime.compareTo(gpsEndDate) < 0) {
                        mileSum = mileSum.add(new BigDecimal(carDailyKm.getMileSum()));
                    }
                }
            }
            fuelFilling.setGpsSumKm(mileSum.toString());
        }

        // 计算百公里油耗
        for (OilBalanceModel fuelBalanceGps : fuelFillings) {
            if (StringUtils.isNotBlank(fuelBalanceGps.getGpsEndDate())) {
                BigDecimal fuelSum = new BigDecimal(fuelBalanceGps.getAddLiters());
                BigDecimal kmSum = new BigDecimal(fuelBalanceGps.getGpsSumKm());
                if (fuelSum.compareTo(BigDecimal.ZERO) == 0 || kmSum.compareTo(BigDecimal.ZERO) == 0) {
                    continue;
                }
                BigDecimal fuelPerHKm = fuelSum.divide(kmSum.divide(new BigDecimal("100")), 2, RoundingMode.HALF_UP);
                fuelBalanceGps.setLitersPerHKm(StringUtils.toString(fuelPerHKm));
            }
        }

        return fuelFillings;
    }

    public List<SelectModel> listDrivers() {
        return oilManDao.listDrivers();
    }

    public List<SelectModel> listTrailers() {
        return oilManDao.listTrailers();
    }
}
