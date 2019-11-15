package com.xzg56.jg.modules.api.gps.service;


import com.xzg56.common.module.sys.persistence.dao.DictDao;
import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.SpringContextHolder;
import com.xzg56.core.utils.WebServiceUtil;
import com.xzg56.jg.modules.api.gps.dao.CarGpsInfoDao;
import com.xzg56.jg.modules.api.gps.logic.CTTokenLogic;
import com.xzg56.jg.modules.api.gps.model.GpsWsModel;
import com.xzg56.jg.modules.api.gps.model.GpsWsReasonModel;
import com.xzg56.utility.DateUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

@Service
@Transactional(readOnly = true)
public class GpsWsService extends BaseService {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	private DictDao dictDao= SpringContextHolder.getBean(DictDao.class);
	@Resource
	private CarGpsInfoDao carGpsInfoDao;

	@Transactional(readOnly = false)
	public String phoneLogin() {
		LinkedHashMap<String, String> wsMap = getWsParamMap("CTCC_NP_LOGIN_PARAM");
		LinkedHashMap<String, String> restfulMap = setPhoneLoginPars(wsMap);
		String returnMsg = callRestfulWebService(restfulMap);
		
		return returnMsg;
	}
	
	@Transactional(readOnly = false)
	public String searchCarList() {
//		String loginMsg = phoneLogin();
//		JSONObject loginJson = JSONObject.fromObject(loginMsg);
		LinkedHashMap<String, String> wsMap = getWsParamMap("CTCC_NP_CARLIST_PARAM");
		LinkedHashMap<String, String> restfulMap = setSearchCarListPars(wsMap);
		String returnMsg = callRestfulWebService(restfulMap);
		
		return returnMsg;
	}
	
	@Transactional(readOnly = false)
	public String searchCarLocation(String carNo) {
		String carListMsg = searchCarList();
		JSONObject carListJson = JSONObject.fromObject(carListMsg);
		LinkedHashMap<String, String> wsMap = getWsParamMap("CTCC_NP_LOCATION_PARAM");
		LinkedHashMap<String, String> restfulMap = setCarLocationPars(wsMap, carListJson, carNo);
		String returnMsg = callRestfulWebService(restfulMap);
		
		return returnMsg;
	}
	
	@Transactional(readOnly = false)
	public String searchCarTrack(GpsWsModel gpsWsModel) {
		String carListMsg = searchCarList();
		JSONObject carListJson = JSONObject.fromObject(carListMsg);
		LinkedHashMap<String, String> wsMap = getWsParamMap("CTCC_NP_TRACK_PARAM");
		LinkedHashMap<String, String> parametersMap = setCarTrackPars(wsMap, carListJson, gpsWsModel);
		String returnMsg = callRestfulWebService(parametersMap);
		
		return returnMsg;
	}
	
	@Transactional(readOnly = false)
	public String searchCarMileage(GpsWsModel gpsWsModel) {
		String carListMsg = searchCarList();
		JSONObject carListJson = JSONObject.fromObject(carListMsg);
		LinkedHashMap<String, String> wsMap = getWsParamMap("CTCC_NP_MILEAGE_PARAM");
		LinkedHashMap<String, String> parametersMap = setCarMileagePars(wsMap, carListJson, gpsWsModel);
		String returnMsg = callRestfulWebService(parametersMap);
		
		return returnMsg;
	}
	
	@Transactional(readOnly = false)
	public List<String> searchCarMileage(List<GpsWsModel> gpsWsList) {
		String carListMsg = searchCarList();
		JSONObject carListJson = JSONObject.fromObject(carListMsg);
		LinkedHashMap<String, String> wsMap = getWsParamMap("CTCC_NP_MILEAGE_PARAM");
		List<LinkedHashMap<String, String>> parametersMap = setCarListMileagePars(wsMap, carListJson, gpsWsList);
		List<String> resultList = new ArrayList<String>();
		String date = "";
		String plateNum = "";
		for (LinkedHashMap<String, String> t : parametersMap) {
			boolean loopFlag = false;
			for (int i=0; i<3;i++) {
				try {
					JSONObject parasJson = JSONObject.fromObject(t.get("PARAS"));
					parasJson.put("USERID", CTTokenLogic.getInstance().getToken());
					t.put("PARAS", parasJson.toString());
					String returnMsg = callRestfulWebService(t);
					JSONObject jsonObj = JSONObject.fromObject(returnMsg);
					if (jsonObj.size() == 0) {
						loopFlag = true;
					} else {
						if (!StringUtils.equals(jsonObj.getString("RET"),"0")) {
							//{"RET":"1","MSG":"轨迹回放查询失败"}
							CTTokenLogic.getInstance().refreshToken();
							if (i < 2) {
								loopFlag = true;
							} else {
								throw new RuntimeException(jsonObj.getString("MSG"));
							}
						}
					}
					//时间 车牌号
					date = DateUtils.formatDate(parasJson.getString("BEGINTIME"),"yyyy-MM-dd");
					plateNum = parasJson.getString("PLATENUM");
					jsonObj.put("PLATENUM", parasJson.get("PLATENUM"));
					jsonObj.put("GPS_PLATENUM", parasJson.get("GPS_PLATENUM"));
					resultList.add(jsonObj.toString());
					if (!loopFlag) {
						break;
					}
				} catch (Exception e) {
					if (i == 2) {
						String msg = "";
						if (StringUtils.isNotBlank(e.getMessage()) && e.getMessage().length() > 500) {
							msg = e.getMessage().substring(0,499);
						} else {
							msg = e.getMessage();
						}
						GpsWsReasonModel gpsWsReasonModel = new GpsWsReasonModel();
						gpsWsReasonModel.setDate(date);
						gpsWsReasonModel.setPlateNum(plateNum);
						gpsWsReasonModel.setReason(msg);
						//将车牌号，时间，错误原因新增表格gps_daily_reason_his
						carGpsInfoDao.addGpsDailyReasonHis(gpsWsReasonModel);
					}
					String yesterday = DateUtils.getDateBefore(1);
					if (StringUtils.equals(date,yesterday)) {
						loopFlag = false;
						continue;
					} else {
						break;
					}
				}
			}
		}
		
		return resultList;
	}
	
	private LinkedHashMap<String, String> getWsParamMap(String type) {
		List<Dict> dictList = dictDao.findByGroupNo(type);

		LinkedHashMap<String,String> map = new LinkedHashMap<String, String>();
		for(Dict d : dictList){
			map.put(d.getLabel(), d.getValue());
		}
		
		return map;
	}
	
	private LinkedHashMap<String, String> setPhoneLoginPars(LinkedHashMap<String,String> map) {
		LinkedHashMap<String, String> restfulMap = new LinkedHashMap<String, String>();
		restfulMap.put("URL", map.get("URL"));
		JSONObject parasJson = new JSONObject();
		parasJson.put("USERNAME", map.get("USERNAME"));
		parasJson.put("PASSWORD", map.get("PASSWORD"));
		parasJson.put("BDTOKENID", map.get("BDTOKENID"));
		parasJson.put("BDCHANNELID", map.get("BDCHANNELID"));
		parasJson.put("MOBILEOS", map.get("MOBILEOS"));
		parasJson.put("USERTYPE", map.get("USERTYPE"));
		restfulMap.put("PARAS", parasJson.toString());
		
		return restfulMap;
	}
	
	private LinkedHashMap<String, String> setSearchCarListPars(LinkedHashMap<String, String> wsMap) {
		LinkedHashMap<String, String> restfulMap = new LinkedHashMap<String, String>();
		restfulMap.put("URL", wsMap.get("URL"));
		JSONObject parasJson = new JSONObject();
		parasJson.put("USERID", CTTokenLogic.getInstance().getToken());
		restfulMap.put("PARAS", parasJson.toString());
		
		return restfulMap;
	}
	
	private LinkedHashMap<String, String> setCarLocationPars(LinkedHashMap<String, String> wsMap, JSONObject carListJson, String carNo) {
		LinkedHashMap<String, String> restfulMap = new LinkedHashMap<String, String>();
		restfulMap.put("URL", wsMap.get("URL"));
		
		JSONObject dataJson = carListJson.getJSONObject("DATA");
		JSONArray carAry = dataJson.getJSONArray("CAR");
		if (carAry.size() > 0) {
			for(int i = 0; i < carAry.size(); i++) {
				JSONObject car = carAry.getJSONObject(i);
				String carNoTemp = car.get("CARNO") == null ? "" : car.get("CARNO").toString().trim();
				
				if (StringUtils.equalsIgnoreCase(carNo, carNoTemp)) {
					JSONObject parasJson = new JSONObject();
					parasJson.put("CARID", car.get("CARID") == null ? "" : car.get("CARID").toString().trim());
					restfulMap.put("PARAS", parasJson.toString());
					break;
				}
			}
		}
		
		return restfulMap;
	}
	
	private LinkedHashMap<String, String> setCarTrackPars(LinkedHashMap<String, String> wsMap, JSONObject carListJson, GpsWsModel gpsWsModel) {
		LinkedHashMap<String, String> restfulMap = new LinkedHashMap<String, String>();
		restfulMap.put("URL", wsMap.get("URL"));
		
		JSONObject dataJson = carListJson.getJSONObject("DATA");
		JSONArray carAry = dataJson.getJSONArray("CAR");
		if (carAry.size() > 0) {
			for(int i = 0; i < carAry.size(); i++) {
				JSONObject car = carAry.getJSONObject(i);
				String carNoTemp = car.get("CARNO") == null ? "" : car.get("CARNO").toString().trim();
				
				if (StringUtils.equalsIgnoreCase(gpsWsModel.getCarNo(), carNoTemp)) {
					JSONObject parasJson = new JSONObject();
					parasJson.put("CARID", car.get("CARID") == null ? "" : car.get("CARID").toString().trim());
					parasJson.put("SPEED", gpsWsModel.getSpeed());
					parasJson.put("BEGINTIME", gpsWsModel.getBeginTime());
					parasJson.put("ENDTIME", gpsWsModel.getEndTime());
					parasJson.put("STARTROW", gpsWsModel.getStartRow());
					parasJson.put("ENDROW", gpsWsModel.getEndRow());
					restfulMap.put("PARAS", parasJson.toString());
					break;
				}
			}
		}
		
		return restfulMap;
	}
	
	private List<LinkedHashMap<String, String>> setCarListMileagePars(LinkedHashMap<String, String> wsMap, JSONObject carListJson, List<GpsWsModel> gpsWsList) {
		Map<String, JSONObject> carInfoMap = new HashMap<String, JSONObject>();
		
		JSONObject dataJson = carListJson.getJSONObject("DATA");
		JSONArray carAry = dataJson.getJSONArray("CAR");
		if (carAry.size() > 0) {
			for(int i = 0; i < carAry.size(); i++) {
				JSONObject car = carAry.getJSONObject(i);
				String carNoTemp = (String)car.get("CARNO");
				if (StringUtils.isNotBlank(carNoTemp)) {
					carInfoMap.put(carNoTemp.trim(), car);
				}
			}
		}
		
		List<LinkedHashMap<String, String>> restfulMapList = new ArrayList<LinkedHashMap<String, String>>();
		for (GpsWsModel gpsWs : gpsWsList) {
			LinkedHashMap<String, String> restfulMap = new LinkedHashMap<String, String>();
			restfulMap.put("URL", wsMap.get("URL"));
			
			JSONObject car = carInfoMap.get(gpsWs.getCarNo().trim());
			JSONObject parasJson = new JSONObject();
			if (car == null) {
				parasJson.put("CARID", "");
			} else {
				parasJson.put("CARID", car.get("CARID") == null ? "" : car.get("CARID").toString().trim());
			}
			parasJson.put("BEGINTIME", gpsWs.getBeginTime());
			parasJson.put("ENDTIME", gpsWs.getEndTime());
			
			parasJson.put("PLATENUM", gpsWs.getPlateNum());
			parasJson.put("GPS_PLATENUM", gpsWs.getCarNo());
			
			restfulMap.put("PARAS", parasJson.toString());
			restfulMapList.add(restfulMap);
		}
		
		return restfulMapList;
	}
	
	private LinkedHashMap<String, String> setCarMileagePars(LinkedHashMap<String, String> wsMap, JSONObject carListJson, GpsWsModel gpsWsModel) {
		LinkedHashMap<String, String> restfulMap = new LinkedHashMap<String, String>();
		restfulMap.put("URL", wsMap.get("URL"));
		
		JSONObject dataJson = carListJson.getJSONObject("DATA");
		JSONArray carAry = dataJson.getJSONArray("CAR");
		if (carAry.size() > 0) {
			for(int i = 0; i < carAry.size(); i++) {
				JSONObject car = carAry.getJSONObject(i);
				String carNoTemp = car.get("CARNO") == null ? "" : car.get("CARNO").toString();
				
				if (StringUtils.equalsIgnoreCase(gpsWsModel.getCarNo(), carNoTemp)) {
					JSONObject parasJson = new JSONObject();
					parasJson.put("CARID", car.get("CARID") == null ? "" : car.get("CARID").toString());
					parasJson.put("BEGINTIME", gpsWsModel.getBeginTime());
					parasJson.put("ENDTIME", gpsWsModel.getEndTime());
					restfulMap.put("PARAS", parasJson.toString());
					break;
				}
			}
		}
		
		return restfulMap;
	}

	private String callRestfulWebService(LinkedHashMap<String, String> restfulMap) {
		String message = WebServiceUtil.callRestfulWebService(restfulMap);
		
		return message;
	}
}