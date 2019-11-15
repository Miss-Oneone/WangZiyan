/**
 * 
 */
package com.xzg56.jg.modules.api.gps.model;


import com.xzg56.core.persistence.BaseModel;
import com.xzg56.utility.DateUtils;

import java.util.Date;

/**
 * @author ZXL
 *
 */
public class MstTrailerModel extends BaseModel {
	
	private static final long serialVersionUID = -4632412760984801078L;
	
	private String plateNum;
	private String gpsPlateNum;
	private String startTime = DateUtils.getSpecifiedDayBeforeStartStr(new Date());
	private String endTime = DateUtils.getSpecifiedDayBeforeEndStr(new Date());

	public String getPlateNum() {
		return plateNum;
	}

	public void setPlateNum(String plateNum) {
		this.plateNum = plateNum;
	}

	public String getGpsPlateNum() {
		return gpsPlateNum;
	}

	public void setGpsPlateNum(String gpsPlateNum) {
		this.gpsPlateNum = gpsPlateNum;
	}
	
	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}