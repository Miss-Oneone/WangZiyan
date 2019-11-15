package com.xzg56.jg.modules.mst.oilManagement.model;


import com.xzg56.core.persistence.BaseModel;

public class FuelFillingDivModel extends BaseModel {

	/**
	 * 插入加油分摊履历表所需字段
	 */
	private static final long serialVersionUID = 1L;

	private String seq;				//seq/加油流水号
	private String ordNo;			//订单号
	private String contnNo;			//集装箱号
	private String ordSts;			//订单状态
	private double liters;			//订单分摊油耗量(升)
	private double litersCheck;		//订单人工分摊油耗量(升)
	private double oilPrice;		//当天油价
	private double thisAddOil;		//加油量
	private String checkPsn;		//核定人
	private String drvordNo;		//派车单号
	private double bugtAdjGas;		//派车单预算-油耗量
	
	public double getBugtAdjGas() {
		return bugtAdjGas;
	}
	public void setBugtAdjGas(double bugtAdjGas) {
		this.bugtAdjGas = bugtAdjGas;
	}
	public String getContnNo() {
		return contnNo;
	}
	public void setContnNo(String contnNo) {
		this.contnNo = contnNo;
	}
	public double getThisAddOil() {
		return thisAddOil;
	}
	public void setThisAddOil(double thisAddOil) {
		this.thisAddOil = thisAddOil;
	}
	public String getDrvordNo() {
		return drvordNo;
	}
	public void setDrvordNo(String drvordNo) {
		this.drvordNo = drvordNo;
	}
	public String getCheckPsn() {
		return checkPsn;
	}
	public void setCheckPsn(String checkPsn) {
		this.checkPsn = checkPsn;
	}
	public String getOrdSts() {
		return ordSts;
	}
	public void setOrdSts(String ordSts) {
		this.ordSts = ordSts;
	}
	public double getLitersCheck() {
		return litersCheck;
	}
	public void setLitersCheck(double litersCheck) {
		this.litersCheck = litersCheck;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public double getLiters() {
		return liters;
	}
	public void setLiters(double liters) {
		this.liters = liters;
	}
	public double getOilPrice() {
		return oilPrice;
	}
	public void setOilPrice(double oilPrice) {
		this.oilPrice = oilPrice;
	}
}
