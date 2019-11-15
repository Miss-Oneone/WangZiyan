package com.xzg56.jg.modules.mst.gps.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.constant.ApiConstant;
import com.xzg56.jg.modules.common.persistence.dao.TrailerDao;
import com.xzg56.jg.modules.mst.gps.model.GpsModel;
import com.xzg56.jg.modules.mst.gps.model.GpsSearchModel;
import com.xzg56.utility.HttpUtils;
import com.xzg56.utility.StringUtils;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by wzr on 2019/4/20.
 */
@Service
@Transactional(readOnly = true)
public class GpsService extends BaseService {

    @Resource
    private TrailerDao trailerDao;

    public List<GpsModel> findGpsSearchModelList(GpsSearchModel gpsSearchModel) {
        // 查询车辆
        List<String> plateNums = new ArrayList<>();
        if (StringUtils.isBlank(gpsSearchModel.getPlateNum())) {
            plateNums = trailerDao.listPlateNums();
        } else {
            plateNums.add(gpsSearchModel.getPlateNum());
        }
        // 查询车辆GPS日里程数据
        List<GpsModel> gpsModels = new ArrayList<>();
        Map<String, String> params = new HashedMap();
        params.put("fromTime", gpsSearchModel.getDateFrom());
        params.put("toTime", gpsSearchModel.getDateTo());
        params.put("plateNums", StringUtils.join(plateNums));
        params.put("compyCode", ApiConstant.GPS_COMPY_CODE);
        String result = HttpUtils.post(ApiConstant.GPS_INTERFACE.MANY_CAR_G_D_K, params, ApiConstant.GPS_SERVICE_APIKEY);
        JSONObject resJson = JSON.parseObject(result);
        if (!StringUtils.equals(resJson.getString("code"), ApiConstant.API_RESULT_STATUS.SUCCESS)) {
            logger.error("GPS日里程获取失败:" +  resJson.getString("msg"));
        } else if (StringUtils.isNotBlank(resJson.getString("data"))) {
            gpsModels = JSON.parseArray(resJson.getString("data"), GpsModel.class);
        }

        SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm");
        for (GpsModel gpsModel : gpsModels) {
            if (StringUtils.isNotBlank(gpsModel.getCreateTime())) {
                gpsModel.setCreateTime(format.format(new Timestamp(StringUtils.toLong(gpsModel.getCreateTime()))));
            }
            gpsModel.setCreateBy(ApiConstant.SYSTEM_USER_NAME);
        }

        return gpsModels;
    }
}
