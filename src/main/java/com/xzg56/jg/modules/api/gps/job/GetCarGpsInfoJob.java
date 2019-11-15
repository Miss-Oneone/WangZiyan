package com.xzg56.jg.modules.api.gps.job;


import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.jg.modules.api.gps.model.CarGpsInfoDetailModel;
import com.xzg56.jg.modules.api.gps.model.CarGpsInfoModel;
import com.xzg56.jg.modules.api.gps.service.CarGpsInfoService;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Component("GetCarGpsInfoJob")
public class GetCarGpsInfoJob {

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private CarGpsInfoService carGpsInfoService;

	public List<CarGpsInfoModel> getCarGpsInfo() {
		List<CarGpsInfoModel> resultList = new ArrayList<CarGpsInfoModel>();
		try {
			resultList = carGpsInfoService.getCarGpsInfo();
		} catch (Exception e) {
			logger.error(e.toString());
		}

		return resultList;
	}

	public List<CarGpsInfoModel> getCarGpsInfoWithPars(String startDate, String endDate, String plateNums) {
		List<CarGpsInfoModel> resultList = new ArrayList<CarGpsInfoModel>();
		try {
			resultList = carGpsInfoService.getCarGpsInfoWithPars(startDate, endDate, plateNums);
		} catch (Exception e) {
			logger.error(e.toString());
		}

		return resultList;
	}

	public List<CarGpsInfoDetailModel> getCarGpsInfoNew() {
		List<CarGpsInfoDetailModel> resultList = new ArrayList<CarGpsInfoDetailModel>();
		String startTime = null;
		String endTime = null;
		int dayOfMonth;
		Calendar month;
		List<Dict> dicts = DictUtils.getDictList("GPS_DAILY_KM");
		if (StringUtils.equals(dicts.get(0).getValue(),"Y")) {
			logger.info("日里程抓取开始！");
			//获取当天
			String str = DateUtils.getDay();
			int len = str.length();// 取得字符串的长度
			int index = 0;// 预定义第一个非零字符串的位置
			char strs[] = str.toCharArray();// 将字符串转化成字符数组
			for (int i = 0; i < len; i++) {
				if ('0' != strs[i]) {
					index = i;// 找到非零字符串并跳出
					break;
				}
			}
			String currentDay = str.substring(index, len);// 截取字符串

			if (StringUtils.equals(currentDay, "1")) {
				month = Calendar.getInstance();
				month.set(Calendar.DAY_OF_MONTH, 1);
				month.add(Calendar.DATE, -1);
				month.set(Calendar.DAY_OF_MONTH, 1);
				dayOfMonth = month.getActualMaximum(Calendar.DAY_OF_MONTH);
			} else {
				//获取当前月第一天
				month = Calendar.getInstance();
				month.add(Calendar.MONTH, 0);
				month.set(Calendar.DAY_OF_MONTH, 1);
				dayOfMonth = StringUtils.toInteger(currentDay)-1;
			}
			for (int i = 0; i < dayOfMonth; i++) {
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Date date = sdf.parse(DateFormatUtils.format(month.getTime(), "yyyy-MM-dd") + " 00:00:00");
					startTime = DateUtils.getSpecifiedDayStartStr(date);
					endTime = DateUtils.getSpecifiedDayEndStr(date);
					month.add(Calendar.DATE, 1);
					resultList = carGpsInfoService.getCarGpsInfoNew(startTime, endTime);
				} catch (Exception e) {
					logger.error(" 开始时间:" + startTime + "结束时间:" + endTime + e.toString());
					continue;
				}
			}
		}
		logger.info("日里程抓取结束！");
		return resultList;
	}

	public List<CarGpsInfoDetailModel> getCarGpsInfoWithParsNew(String startDate, String endDate, String plateNums) {
		List<CarGpsInfoDetailModel> resultList = new ArrayList<CarGpsInfoDetailModel>();
		try {
			resultList = carGpsInfoService.getCarGpsInfoWithParsNew(startDate, endDate, plateNums);
		} catch (Exception e) {
			logger.error(e.toString());
		}

		return resultList;
	}
}