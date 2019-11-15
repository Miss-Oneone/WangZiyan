package com.xzg56.jg.modules.mst.oilManagement.model;

import com.xzg56.core.persistence.BaseModel;

public class OilShareTableModel extends BaseModel {

	/**
	 * 装载加油分摊信息的model
	 */
	private static final long serialVersionUID = 1L;
	
	private String eSeqNo;					//加油分摊履历表序号
	private String drvordNo;				//派车单号
	private String contnNo;					//集装箱号
	private String bugtAdjGas;				//派车-预算油耗（升）
	private String liters;					//实际油耗-系统分摊（升
	private String litersCheck;				//实际油耗-人工核认（升）
	private String updatePsn;				//更新者
	
	public String geteSeqNo() {
		return eSeqNo;
	}
	public void seteSeqNo(String eSeqNo) {
		this.eSeqNo = eSeqNo;
	}
	public String getDrvordNo() {
		return drvordNo;
	}
	public void setDrvordNo(String drvordNo) {
		this.drvordNo = drvordNo;
	}
	public String getContnNo() {
		return contnNo;
	}
	public void setContnNo(String contnNo) {
		this.contnNo = contnNo;
	}
	public String getBugtAdjGas() {
		return bugtAdjGas;
	}
	public void setBugtAdjGas(String bugtAdjGas) {
		this.bugtAdjGas = bugtAdjGas;
	}
	public String getLiters() {
		return liters;
	}
	public void setLiters(String liters) {
		this.liters = liters;
	}
	public String getLitersCheck() {
		return litersCheck;
	}
	public void setLitersCheck(String litersCheck) {
		this.litersCheck = litersCheck;
	}
	public String getUpdatePsn() {
		return updatePsn;
	}
	public void setUpdatePsn(String updatePsn) {
		this.updatePsn = updatePsn;
	}
	
}