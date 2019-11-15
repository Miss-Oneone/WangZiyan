package com.xzg56.jg.modules.mst.oilManagement.dao;

import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.oilManagement.model.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface OilSearchDao {
	/**
	 * 查询所有的加油记录
	 * @param conModel
	 * @return List<OilSearchModel>
	 */
	List<OilSearchModel> findOilRecordList(OilSearch conModel);
	
	/**
	 * 插入加油信息，并返回加油信息的seq
	 * @param oilSearchModel
	 * @return int
	 */
	int oilAdd(OilSearchModel oilSearchModel);
	
	/**
	 * 查询所有的车辆号
	 * @return List<OilSearchModel>
	 */
	List<OilSearchModel> getAllPlateNum();
	
	/**
	 * 查询所有的在职司机姓名
	 * @return List<OilSearchModel>
	 */
	List<OilSearchModel> getAllDriverName();
	

	/**
	 * 通过seq查询上一次的加油信息
	 * @param seq
	 * @return OilShareFormModel
	 */
	OilShareFormModel getLastMessageBySeq(@Param("seq") String seq);

	/**
	 * 通过车辆号查询上一次的加油信息
	 * @param plateNum
	 * @return OilShareFormModel
	 */
	OilShareFormModel getLastMessage(@Param("plateNum") String plateNum);

	/**
	 * 通过seq查询本次的加油信息
	 * @param seq
	 * @return OilShareFormModel
	 */
	OilShareFormModel getThisMessage(@Param("seq") String seq);

	/**
	 * 通过seq查询加油分摊履历表的信息
	 * @param seq
	 * @return List<OilShareTableModel>
	 */
	List<OilShareTableModel> getShareMessage(@Param("seq") String seq);

	/**
	 * 通过车牌号查找对应的司机信息
	 * @param plateNum
	 * @return OilSearchModel
	 */
	OilSearchModel findDriver(@Param("plateNum") String plateNum);

	/**
	 * 通过司机编码查找对应的车辆信息
	 * @param driverCode
	 * @return OilSearchModel
	 */
	OilSearchModel findTrailer(@Param("driverCode") String driverCode);

	/**
	 * 查询最新油价
	 * @param fuelType
	 * @param innerFlag
	 * @return double
	 */
	String getOilPrice(@Param("fuelType") String fuelType, @Param("innerFlag") String innerFlag);

	/**
	 * 查询获取所有订单的运输订单预算-核定-油耗总计
	 * @param driverCode
	 * @return List<FuelFillingDivModel>
	 */
	List<FuelFillingDivModel> getAllDrv(@Param("lastAddTime") String lastAddTime, @Param("driverCode") String driverCode);

	/**
	 * 通过司机编码查询司机的存油量
	 * @param driverCode
	 * @return String
	 */
	String getDriStorageOil(@Param("driverCode") String driverCode);
	
	/**
	 * 添加加油记录信息
	 * @param oilSearchModel
	 */
	void insertFuelFilling(OilSearchModel oilSearchModel);
	
	/**
	 * 添加实付记录信息
	 * @param payAble
	 */
	void insertOrdActPayable(ActPayAbleModel payAble);
	
	/**
	 * 添加加油分摊履历信息
	 * @param ffdm
	 */
	void insertFuelFillingDiv(FuelFillingDivModel ffdm);
	
	/**
	 * 更新加油分摊履历信息
	 * @param ostm
	 */
	void updateFuelFillingDiv(OilShareTableModel ostm);
	
	/**
	 * 更新司机的存油量信息
	 * @param oilSearch
	 */
	void updateStorageOil(OilSearchModel oilSearch);

	//查询导出加油记录的信息
	List<OilSearchExcelModel> findOilMsg(OilSearch conModel);

	//导入数据查询司机编码
	String getDriverCode(String driver);

	//查找挂靠司机编码
	String getAttachDriverCode(String driver);

	//导入加油记录信息插入数据库
	void insertOilMsg(OilSearchExcelModel oilVO);

	//导入时更新加油记录表修改数据
	void updateOilMsg(OilSearchExcelModel oilVO);

	//查询修改信息
	OilSearchModel findReviseOilMsg(String seqNo);

	//更新修改信息
	void updateFuelFilling(OilSearchModel oilSearchModel);

	int countTrailersByPlateNum(@Param("plateNum") String plateNum);

	void deleteFuelFilling(@Param("seqNo") String seqNo);

	void deleteFuelFillingIdLink(@Param("seqNo") String seqNo);

	List<OilSearchModel> listDriversByPlateNums(List<String> plateNums);

	/**
	 * 获取燃油的类型
	 * @return List<Dict>
	 */
	List<Dict> getOilType();
}
