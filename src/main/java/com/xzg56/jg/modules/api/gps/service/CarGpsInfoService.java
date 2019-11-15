package com.xzg56.jg.modules.api.gps.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.xzg56.common.module.sys.persistence.dao.DictDao;
import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.SpringContextHolder;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.core.utils.WebServiceUtil;
import com.xzg56.jg.modules.api.gps.dao.CarGpsInfoDao;
import com.xzg56.jg.modules.api.gps.model.*;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;
import com.xzg56.utility.XmlConverUtil;
import net.sf.json.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional(readOnly = true)
public class CarGpsInfoService extends BaseService {

    private Logger logger = LoggerFactory.getLogger(getClass());
    private DictDao dictDao = SpringContextHolder.getBean(DictDao.class);
    private CarGpsInfoDao carGpsInfoDao = SpringContextHolder.getBean(CarGpsInfoDao.class);
    private GpsWsService gpsWsService = SpringContextHolder.getBean(GpsWsService.class);
    private static final String gpsHostUrl = "http://220.162.239.162:7003/phoneAction";

    @Transactional(readOnly = false)
    public List<CarGpsInfoDetailModel> getCarGpsInfoNew(String startTime, String endTime) {
        List<MstTrailerModel> trailerList = carGpsInfoDao.findMstTrailers();
        List<GpsWsModel> gpsWsList = new ArrayList<GpsWsModel>();
        if (CollectionUtils.isNotEmpty(trailerList)) {
            for (MstTrailerModel trailer : trailerList) {
                GpsWsModel gpsWsModel = new GpsWsModel();
                gpsWsModel.setPlateNum(trailer.getPlateNum());
                gpsWsModel.setCarNo(trailer.getGpsPlateNum());
                gpsWsModel.setBeginTime(startTime);
                gpsWsModel.setEndTime(endTime);
                gpsWsList.add(gpsWsModel);
            }
        }

        List<String> resultMsgList = gpsWsService.searchCarMileage(gpsWsList);
        List<CarGpsInfoDetailModel> t = parseResultMsgNew(startTime, endTime, resultMsgList,false);
        return t;
    }

    /**
     * 获取更新t_sys_parameter返回值
     */
    @Transactional(readOnly = false)
    public int getUpdateTSysParameterResult(String updateTime){

        return carGpsInfoDao.updateTSysParameter(updateTime);
    }

    /**
     * 更新t_sys_parameter
     */
    @Transactional(readOnly = false)
    public void updateTSysParameter(){

        carGpsInfoDao.updateTSysP();
    }


    @Transactional(readOnly = false)
    public List<CarGpsInfoDetailModel> getCarGpsInfoWithParsNew(String startDate, String endDate, String plateNums) {
        String startTime = DateUtils.getSpecifiedDayStartStr(startDate);
        String endTime = DateUtils.getSpecifiedDayEndStr(endDate);
        List<MstTrailerModel> trailerList = carGpsInfoDao.findMstTrailers();
        List<GpsWsModel> gpsWsList = new ArrayList<GpsWsModel>();

        if (StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {

            if (StringUtils.isNotBlank(plateNums)) {
                Map<String, String> trailerMap = new HashMap<String, String>();
                if (CollectionUtils.isNotEmpty(trailerList)) {
                    for (MstTrailerModel trailer : trailerList) {
                        trailerMap.put(trailer.getPlateNum(), trailer.getGpsPlateNum());
                    }
                }

                String[] plateNumAry = plateNums.split(",");
                for (String plateNum : plateNumAry) {
                    GpsWsModel gpsWsModel = new GpsWsModel();
                    gpsWsModel.setPlateNum(plateNum);
                    gpsWsModel.setCarNo(trailerMap.get(plateNum));
                    gpsWsModel.setBeginTime(startTime);
                    gpsWsModel.setEndTime(endTime);
                    gpsWsList.add(gpsWsModel);
                }
            } else {
                if (CollectionUtils.isNotEmpty(trailerList)) {
                    for (MstTrailerModel trailer : trailerList) {
                        GpsWsModel gpsWsModel = new GpsWsModel();
                        gpsWsModel.setPlateNum(trailer.getPlateNum());
                        gpsWsModel.setCarNo(trailer.getGpsPlateNum());
                        gpsWsModel.setBeginTime(startTime);
                        gpsWsModel.setEndTime(endTime);
                        gpsWsList.add(gpsWsModel);
                    }
                }
            }
        }

        List<String> resultMsgList = gpsWsService.searchCarMileage(gpsWsList);
        List<CarGpsInfoDetailModel> t = parseResultMsgNew(startTime, endTime, resultMsgList,false);

        return t;
    }

    @Transactional(readOnly = false)
    public List<CarGpsInfoDetailModel> getCarGpsInfoWithParsNews(String startDate, String endDate, String plateNums,boolean flag) {
        String startTime = DateUtils.getSpecifiedDayStartStr(startDate);
        String endTime = DateUtils.getSpecifiedDayEndStr(endDate);
        List<MstTrailerModel> trailerList = carGpsInfoDao.findMstTrailers();
        List<GpsWsModel> gpsWsList = new ArrayList<GpsWsModel>();

        if (StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {

            if (StringUtils.isNotBlank(plateNums)) {
                Map<String, String> trailerMap = new HashMap<String, String>();
                if (CollectionUtils.isNotEmpty(trailerList)) {
                    for (MstTrailerModel trailer : trailerList) {
                        trailerMap.put(trailer.getPlateNum(), trailer.getGpsPlateNum());
                    }
                }

                String[] plateNumAry = plateNums.split(",");
                for (String plateNum : plateNumAry) {
                    GpsWsModel gpsWsModel = new GpsWsModel();
                    gpsWsModel.setPlateNum(plateNum);
                    gpsWsModel.setCarNo(trailerMap.get(plateNum));
                    gpsWsModel.setBeginTime(startTime);
                    gpsWsModel.setEndTime(endTime);
                    gpsWsList.add(gpsWsModel);
                }
            } else {
                if (CollectionUtils.isNotEmpty(trailerList)) {
                    for (MstTrailerModel trailer : trailerList) {
                        GpsWsModel gpsWsModel = new GpsWsModel();
                        gpsWsModel.setPlateNum(trailer.getPlateNum());
                        gpsWsModel.setCarNo(trailer.getGpsPlateNum());
                        gpsWsModel.setBeginTime(startTime);
                        gpsWsModel.setEndTime(endTime);
                        gpsWsList.add(gpsWsModel);
                    }
                }
            }
        }

        List<String> resultMsgList = gpsWsService.searchCarMileage(gpsWsList);
        List<CarGpsInfoDetailModel> t = parseResultMsgNew(startTime, endTime, resultMsgList,flag);

        return t;
    }

    //flag:手工抓取标志 updateTime:手工抓取更新时间
    private List<CarGpsInfoDetailModel> parseResultMsgNew(String startTime, String endTime, List<String> resultList,Boolean flag) {
        List<CarGpsInfoDetailModel> resultModelList = new ArrayList<CarGpsInfoDetailModel>();
        if (CollectionUtils.isNotEmpty(resultList)) {
            for (String result : resultList) {
                JSONObject jsonObj = JSONObject.fromObject(result);
                String plateNum = jsonObj.getString("PLATENUM");
                String gpsPlateNum = jsonObj.get("GPS_PLATENUM") == null ? "" : jsonObj.get("GPS_PLATENUM").toString();
                String resultFlag = jsonObj.getString("RET");
                String resultMsg = jsonObj.getString("MSG");
                JSONObject dataJson = jsonObj.getJSONObject("DATA");
                if (StringUtils.isNotBlank(resultFlag)) {
                    if (StringUtils.equalsIgnoreCase(resultFlag, "0")) {
                        CarGpsInfoDetailModel detail = new CarGpsInfoDetailModel();
                        detail.setPlateNum(plateNum);
                        detail.setCarNo(gpsPlateNum);
                        detail.setMileSum(dataJson.getString("MILEAGE"));
                        detail.setMsg(resultMsg);
                        detail.setResultFlag(resultFlag);
                        detail.setBeginTime(startTime);
                        detail.setEndTime(endTime);
                        CarGpsInfoDetailModel carGpsInfoDetail = carGpsInfoDao.getCarGpsDailyKmByKey(detail);
                        if (carGpsInfoDetail != null) {
                            detail.setUpdateBy(UserUtils.getUser().getId() == null ? "999" : UserUtils.getUser().getId().toString());
                            detail.setUpdateTime(new Date());
                            DecimalFormat df = new DecimalFormat("0.00");
                            String  differenceMileSum = df.format(StringUtils.toDouble(detail.getMileSum())- StringUtils.toDouble(carGpsInfoDetail.getMileSum()));
                            detail.setDifferenceMileSum(StringUtils.toString(differenceMileSum));
                            carGpsInfoDao.updateGpsDailyKm(detail);
                        } else {
                            detail.setCreateBy(UserUtils.getUser().getId() == null ? "999" : UserUtils.getUser().getId().toString());
                            detail.setCreateTime(new Date());

                            carGpsInfoDao.insertGpsDailyKm(detail);
                        }
                        if (flag) {
                            detail.setCreateBy(UserUtils.getUser().getId() == null ? "999" : UserUtils.getUser().getId().toString());
                            detail.setCreateTime(new Date());
                            carGpsInfoDao.insertGpsDailyKmResume(detail);
                        }
                        resultModelList.add(detail);
                    } else {
                        CarGpsInfoDetailModel detail = new CarGpsInfoDetailModel();
                        detail.setPlateNum(plateNum);
                        detail.setCarNo(gpsPlateNum);
                        detail.setMileSum("");
                        detail.setMsg(resultMsg);
                        detail.setResultFlag(resultFlag);
                        detail.setBeginTime(startTime);
                        detail.setEndTime(endTime);
                        resultModelList.add(detail);
                    }
                } else {
                    //fail
                    CarGpsInfoDetailModel detail = new CarGpsInfoDetailModel();
                    detail.setPlateNum(plateNum);
                    detail.setCarNo(gpsPlateNum);
                    detail.setMileSum("");
                    detail.setMsg("exception");
                    detail.setResultFlag("99");
                    detail.setBeginTime(startTime);
                    detail.setEndTime(endTime);
                    resultModelList.add(detail);
                }
            }
        }

        return resultModelList;
    }

    @Transactional(readOnly = false)
    public List<CarGpsInfoModel> getCarGpsInfo() {
        String startTime = DateUtils.getSpecifiedDayBeforeStartStr(new Date());
        String endTime = DateUtils.getSpecifiedDayBeforeEndStr(new Date());
        List<CarGpsInfoModel> resultList = new ArrayList<CarGpsInfoModel>();
        String carNo = "";

        LinkedHashMap<String, String> map = getGpsParamMap();
        LinkedHashMap<String, String> parameters = setCommonPars(map);
        List<MstTrailerModel> trailerList = carGpsInfoDao.findMstTrailers();

        if (CollectionUtils.isNotEmpty(trailerList)) {
            for (MstTrailerModel trailer : trailerList) {
                carNo = trailer.getGpsPlateNum();
                MstTrailerModel trailerModel = createTrailerModel(startTime, endTime, carNo);
                setSpecialPars(parameters, trailerModel);
                String message = callCsWebService(map, parameters);
                parseResultMsg(startTime, endTime, resultList, trailer.getPlateNum(), carNo, message);
            }
        }

        return resultList;
    }

    @Transactional(readOnly = false)
    public List<CarGpsInfoModel> getCarGpsInfoWithPars(String startDate, String endDate, String plateNums) {
        List<CarGpsInfoModel> resultList = new ArrayList<CarGpsInfoModel>();

        String startTime = DateUtils.getSpecifiedDayStartStr(startDate);//DateUtils.getSpecifiedDayBeforeStartStr(startDate);//getSpecifiedDayBeforeStartStr(new Date());
        String endTime = DateUtils.getSpecifiedDayEndStr(endDate);//DateUtils.getSpecifiedDayBeforeEndStr(endDate);//getSpecifiedDayBeforeEndStr(new Date());
        String carNo = "";
        List<MstTrailerModel> trailerList = carGpsInfoDao.findMstTrailers();

        if (StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
            LinkedHashMap<String, String> map = getGpsParamMap();
            LinkedHashMap<String, String> parameters = setCommonPars(map);

            if (StringUtils.isNotBlank(plateNums)) {

                Map<String, String> trailerMap = new HashMap<String, String>();
                if (CollectionUtils.isNotEmpty(trailerList)) {
                    for (MstTrailerModel trailer : trailerList) {
                        trailerMap.put(trailer.getPlateNum(), trailer.getGpsPlateNum());
                    }
                }

                String[] plateNumAry = plateNums.split(",");
                for (String plateNum : plateNumAry) {
                    carNo = trailerMap.get(plateNum);
                    MstTrailerModel trailerModel = createTrailerModel(startTime, endTime, carNo);
                    setSpecialPars(parameters, trailerModel);
                    String message = callCsWebService(map, parameters);
                    parseResultMsg(startTime, endTime, resultList, plateNum, carNo, message);
                }
            } else {
//				List<MstTrailerModel> trailerList = containerDao.findMstTrailer();
                if (CollectionUtils.isNotEmpty(trailerList)) {
                    for (MstTrailerModel trailer : trailerList) {
                        carNo = trailer.getGpsPlateNum();
                        MstTrailerModel trailerModel = createTrailerModel(startTime, endTime, carNo);
                        setSpecialPars(parameters, trailerModel);
                        String message = callCsWebService(map, parameters);
                        parseResultMsg(startTime, endTime, resultList, trailer.getPlateNum(), carNo, message);
                    }
                }
            }
        }

        return resultList;
    }

    private LinkedHashMap<String, String> getGpsParamMap() {
        List<Dict> dictList = dictDao.findByGroupNo("GPS_PARAM");

        LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
        for (Dict d : dictList) {
            map.put(d.getLabel(), d.getValue());
        }

        return map;
    }

    private LinkedHashMap<String, String> setCommonPars(LinkedHashMap<String, String> map) {
        LinkedHashMap<String, String> parameters = new LinkedHashMap<String, String>();
        parameters.put("in0", map.get("GPS_USERNAME"));
        parameters.put("in1", map.get("GPS_PASSWORD"));
//		parameters.put("in2", "");
        return parameters;
    }

    private MstTrailerModel createTrailerModel(String startTime, String endTime, String carNo) {
        MstTrailerModel trailerModel = new MstTrailerModel();
        trailerModel.setPlateNum(carNo);
        trailerModel.setStartTime(startTime);
        trailerModel.setEndTime(endTime);

        return trailerModel;
    }

    private void setSpecialPars(LinkedHashMap<String, String> parameters, MstTrailerModel trailerModel) {
        parameters.put("in2", trailerModel.getPlateNum());
        parameters.put("in3", "");
        parameters.put("in4", trailerModel.getStartTime());
        parameters.put("in5", StringUtils.isNotBlank(trailerModel.getEndTime()) ? trailerModel.getEndTime() : DateUtils.getDateTime());
    }

    private String callCsWebService(LinkedHashMap<String, String> map, LinkedHashMap<String, String> parameters) {
        String message = WebServiceUtil.callCsWebService(map.get("GPS_URL"), map.get("GPS_NAMESPACE"), map.get("GPS_METHOD"), parameters);
        return message;
    }

    private void parseResultMsg(String startTime, String endTime, List<CarGpsInfoModel> resultList, String plateNum, String gpsPlateNum, String message) {
        if (StringUtils.isNotBlank(message)) {
            String result = XmlConverUtil.xmltoJson(message);
            JSONObject jsonObj = JSONObject.fromObject(result);
            String carListStr = jsonObj.getString("carList");
            if (StringUtils.equalsIgnoreCase(carListStr, "[]")) {
                logger.warn(plateNum + ": detail data is empty!");

                JSONObject virtualSubJson = new JSONObject();
                virtualSubJson.put("beginTime", startTime);
                virtualSubJson.put("endTime", endTime);
                virtualSubJson.put("plateNum", plateNum);
                virtualSubJson.put("carNo", gpsPlateNum);
                virtualSubJson.put("mileSum", "0.00");
                JSONObject virtualJson = new JSONObject();
                virtualJson.put("car", virtualSubJson);

                jsonObj.remove("carList");
                jsonObj.put("carList", virtualJson);
            }
            Map<String, Class> classMap = new HashMap<String, Class>();
            classMap.put("carList", CarGpsInfoSubModel.class);
            classMap.put("car", CarGpsInfoDetailModel.class);
            CarGpsInfoModel carGpsInfoModel = (CarGpsInfoModel) JSONObject.toBean(jsonObj, CarGpsInfoModel.class, classMap);
            CarGpsInfoDetailModel detail = carGpsInfoModel.getCarList().getCar();
            detail.setPlateNum(plateNum);
            CarGpsInfoDetailModel carGpsInfoDetail = carGpsInfoDao.getCarGpsDailyKmByKey(detail);

            if (carGpsInfoDetail != null) {
                detail.setUpdateBy(UserUtils.getUser().getId() == null ? "999" : UserUtils.getUser().getId().toString());
                detail.setUpdateTime(new Date());

                carGpsInfoDao.updateGpsDailyKm(detail);
            } else {
                detail.setCreateBy(UserUtils.getUser().getId() == null ? "999" : UserUtils.getUser().getId().toString());
                detail.setCreateTime(new Date());

                carGpsInfoDao.insertGpsDailyKm(detail);
            }

            resultList.add(carGpsInfoModel);
        } else {
            logger.warn(plateNum + ": no anything data!");

            CarGpsInfoModel notExistCarGpsInfo = new CarGpsInfoModel();
            notExistCarGpsInfo.setStatus("99");
            notExistCarGpsInfo.setSummary(plateNum + ": no anything data!");
            resultList.add(notExistCarGpsInfo);
        }
    }

    /**
     * 根据车牌查车辆实时定位
     */
    public List<CarGpsLocationInfoModel> getCarRealtimeGpsInfoByLicensePlate(String carPlateNum) {

        List<JSONObject> paramList = new ArrayList<>();
        JSONObject param = new JSONObject();
        String postResult = "";
        List<CarGpsLocationInfoModel> carGpsLocationInfoModelList = new ArrayList<>();
        JSONArray jsonArray;
        com.alibaba.fastjson.JSONObject jsonObject;
        //1.获取车辆列表
        List<CarGpsCarInfoModel> carInfoModels = findCarInfoList();
        //2.获取车牌对应的GPS车牌号列表
        List<String> gpsPlateNumList = findCarIdByCarPlateNum(carPlateNum, carInfoModels);
        for (String gpsPlateNum : gpsPlateNumList) {
            for (CarGpsCarInfoModel model : carInfoModels) {
                if (gpsPlateNum.equals(model.getCarNo().trim())) {
                    param.put("CARID", model.getCarId());
                    paramList.add(param);
                    postResult = sendPost(gpsHostUrl + "/searchCarLocation.do", JSON.toJSONString(paramList).replace("[", "").replace("]", ""));
                    postResult = "[" + postResult + "]";
                    jsonArray = JSON.parseArray(postResult);
                    jsonObject = jsonArray.getJSONObject(0);
                    CarGpsLocationInfoModel carGpsLocationInfoModel = JSON.parseObject(jsonObject.getString("DATA"), CarGpsLocationInfoModel.class);
                    if (carGpsLocationInfoModel != null) {
                        carGpsLocationInfoModel.setGpsPlateNum(gpsPlateNum);
                        carGpsLocationInfoModelList.add(carGpsLocationInfoModel);
                    }
                    param.clear();
                    paramList.clear();
                    break;
                }
            }
        }
        return carGpsLocationInfoModelList;
    }

    /**
     * 根据车牌号、开始时间、结束时间获取车辆轨迹
     *
     * @param carPlateNum
     * @param beginTime
     * @param endTime
     * @return
     */
    public List<CarGpsLocationInfoModel> getCarCanvasInTimes(String carPlateNum, String beginTime, String endTime) {
        List<CarGpsLocationInfoModel> carGpsLocationInfoModelList = new ArrayList<>();
        List<JSONObject> paramList = new ArrayList<>();
        JSONObject param = new JSONObject();
        String postResult = "";
        JSONArray jsonArray;
        com.alibaba.fastjson.JSONObject jsonObject;
        //1.获取车辆列表
        List<CarGpsCarInfoModel> carInfoModels = findCarInfoList();
        try {
            //2.获取车牌对应的GPS车牌号列表
            List<String> gpsPlateNumList = findCarIdByCarPlateNum(carPlateNum, carInfoModels);
            for (String gpsPlateNum : gpsPlateNumList) {
                for (CarGpsCarInfoModel model : carInfoModels) {
                    if (gpsPlateNum.equals(model.getCarNo().trim())) {
                        param.put("CARID", model.getCarId());
                        param.put("SPEED", "2");
                        param.put("BEGINTIME", beginTime);
                        param.put("ENDTIME", endTime);
                        param.put("STARTROW", "0");
                        param.put("ENDROW", "");
                        paramList.add(param);
                        postResult = sendPost(gpsHostUrl + "/searchCarTrack.do", JSON.toJSONString(paramList).replace("[", "").replace("]", ""));
                        postResult = "[" + postResult + "]";
                        jsonArray = JSON.parseArray(postResult);
                        jsonObject = jsonArray.getJSONObject(0);
                        carGpsLocationInfoModelList = JSON.parseArray(jsonObject.getString("DATA"), CarGpsLocationInfoModel.class);
                        param.clear();
                        paramList.clear();
                        break;
                    }
                }
                break;
            }
        } catch (Exception e) {
            logger.error(e.getMessage() + postResult);
        }

        return carGpsLocationInfoModelList;
    }

    public List<DzkaGpsCanvarModel> getCarCanvasForDzka(String carPlateNum, Timestamp beginTime, Timestamp endTime) {
        List<DzkaGpsCanvarModel> resultList = new ArrayList<>();
        resultList = carGpsInfoDao.getCarGpsCanvas(carPlateNum, beginTime, endTime);
        return resultList;
    }

    /**
     * 通过车牌获取GPS车牌
     *
     * @param carPlateNum
     * @return
     */
    public List<String> findCarIdByCarPlateNum(String carPlateNum, List<CarGpsCarInfoModel> carInfoModels) {

        List<String> gpsPlateNumList = new ArrayList<>();
        if (!StringUtils.isBlank(carPlateNum)) {
            //获取参数车牌的GPS车牌
            String gpsPlateNum = carGpsInfoDao.findGpsPlateNumByPlateNum(carPlateNum);
            if (StringUtils.isNotBlank(gpsPlateNum)) {
                gpsPlateNumList.add(gpsPlateNum);
            }
        } else {
            gpsPlateNumList = carGpsInfoDao.findGpsPlateNumList();
        }

        return gpsPlateNumList;
    }

    /**
     * 获取车辆信息列表
     *
     * @return
     */
    public List<CarGpsCarInfoModel> findCarInfoList() {
        //1.登录，获取userId
        List<JSONObject> paramList = new ArrayList<>();
        JSONObject param = new JSONObject();
        String userName = "";
        String password = "";
        List<Dict> dicts = DictUtils.getDictList("CTCC_NP_LOGIN_PARAM");
        for (Dict dict: dicts) {
            if (StringUtils.equals(dict.getLabel(),"USERNAME")) {
                userName = dict.getValue();
            }
            if (StringUtils.equals(dict.getLabel(),"PASSWORD")) {
                password = dict.getValue();
            }
        }
        param.put("USERNAME", userName);
        param.put("PASSWORD", password);
        param.put("BDTOKENID", "232");
        param.put("BDCHANNELID", "333");
        param.put("USERTYPE", "0");
        param.put("MOBILEOS", "0");
        paramList.add(param);
        String postResult = sendPost(gpsHostUrl + "/phoneLogin.do", JSON.toJSONString(paramList).replace("[", "").replace("]", ""));
        postResult = "[" + postResult + "]";
        JSONArray jsonArray = JSON.parseArray(postResult);
        com.alibaba.fastjson.JSONObject jsonObject = jsonArray.getJSONObject(0);
        CarGpsUserInfoModel carGpsUserInfoModel = JSON.parseObject(jsonObject.getString("DATA"), CarGpsUserInfoModel.class);
        paramList.clear();
        param.clear();
        //2.查询车辆列表，匹配该车牌对应的carId
        param.put("USERID", carGpsUserInfoModel.getUserId());
        paramList.add(param);
        postResult = sendPost(gpsHostUrl + "/searchCarList.do", JSON.toJSONString(paramList).replace("[", "").replace("]", ""));
        postResult = "[" + postResult + "]";
        jsonArray = JSON.parseArray(postResult);
        jsonObject = jsonArray.getJSONObject(0);
        com.alibaba.fastjson.JSONObject data = com.alibaba.fastjson.JSONObject.parseObject(jsonObject.getString("DATA"));
        List<CarGpsCarInfoModel> carInfoModels = new ArrayList<>();
        if (StringUtils.isNotBlank(data)) {
            carInfoModels = JSON.parseArray(data.getString("CAR"), CarGpsCarInfoModel.class);
        }
        paramList.clear();
        param.clear();
        return carInfoModels;
    }


    //post请求方法
    public String sendPost(String url, String data) {
        String response = null;
        try {
            CloseableHttpClient httpclient = null;
            CloseableHttpResponse httpresponse = null;
            try {
                httpclient = HttpClients.createDefault();
                HttpPost httppost = new HttpPost(url);
                StringEntity stringentity = new StringEntity(data, ContentType.create("text/json", "UTF-8"));
                httppost.setEntity(stringentity);
                httpresponse = httpclient.execute(httppost);
                response = EntityUtils.toString(httpresponse.getEntity());
            } finally {
                if (httpclient != null) {
                    httpclient.close();
                }
                if (httpresponse != null) {
                    httpresponse.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }

    //获取某月的最后一天
    private String getLastDayOfMonth(int year, int month) {
        Calendar cal = Calendar.getInstance();
        //设置年份
        cal.set(Calendar.YEAR, year);
        //设置月份
        cal.set(Calendar.MONTH, month - 1);
        //获取某月最大天数
        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        //设置日历中月份的最大天数
        cal.set(Calendar.DAY_OF_MONTH, lastDay);
        //格式化日期
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String lastDayOfMonth = sdf.format(cal.getTime());
        return lastDayOfMonth;
    }
}