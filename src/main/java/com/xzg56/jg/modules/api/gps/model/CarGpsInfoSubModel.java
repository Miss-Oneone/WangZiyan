package com.xzg56.jg.modules.api.gps.model;


import com.xzg56.core.persistence.BaseModel;

public class CarGpsInfoSubModel extends BaseModel {

	private static final long serialVersionUID = 3355592132165951018L;
	
	private CarGpsInfoDetailModel car;

	public CarGpsInfoDetailModel getCar() {
		return car;
	}

	public void setCar(CarGpsInfoDetailModel car) {
		this.car = car;
	}
}