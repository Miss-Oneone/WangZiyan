package com.xzg56.jg.modules.mst.oilManagement.service;

import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.service.ServiceException;
import com.xzg56.core.utils.MessageUtil;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.jg.modules.common.persistence.dao.FuelFillingIdLinkDao;
import com.xzg56.jg.modules.common.persistence.entity.FuelFillingIdLink;
import com.xzg56.jg.modules.mst.oilManagement.dao.OilSearchDao;
import com.xzg56.jg.modules.mst.oilManagement.model.*;
import com.xzg56.utility.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = false)
public class OilSearchService extends BaseService {
	
	@Autowired
	private OilSearchDao oilSearchDao;

	@Autowired
	private FuelFillingIdLinkDao fuelFillingIdLinkDao;

	/**
	 * 查询所有的加油记录
	 * @param conModel
	 * @return List<OilSearchModel>
	 */
	public List<OilSearchModel> findOilRecordList(OilSearch conModel) {
		return oilSearchDao.findOilRecordList(conModel);
	}

	/**
	 * 插入加油信息，并返回加油信息的seq
	 * @param oilSearchModel
	 * @return int
	 */
	public int oilAdd(OilSearchModel oilSearchModel){
		return oilSearchDao.oilAdd(oilSearchModel);
	}
	
	/**
	 * 查询所有的车辆号
	 * @return List<OilSearchModel>
	 */
	public List<OilSearchModel> getAllPlateNum(){
		return oilSearchDao.getAllPlateNum();
	}
	
	/**
	 * 查询所有的在职司机姓名
	 * @return List<OilSearchModel>
	 */
	public List<OilSearchModel> getAllDriverName(){
		return oilSearchDao.getAllDriverName();
	}
	
	/**
	 * 通过seq查询上一次的加油信息
	 * @param seq
	 * @return OilShareFormModel
	 */
	public OilShareFormModel getLastMessageBySeq(String seq){
		return oilSearchDao.getLastMessageBySeq(seq);
	}

	/**
	 * 获取燃油的类型
	 * @return List<Dict>
	 */
	/**
	 * 获取燃油的类型
	 * @return List<Dict>
	 */
	public List<Dict> getOilType(){
		return oilSearchDao.getOilType();
	}

	/**
	 * 通过车辆号查询上一次的加油信息
	 * @param plateNum
	 * @return OilShareFormModel
	 */
	public OilShareFormModel getLastMessage(String plateNum){
		return oilSearchDao.getLastMessage(plateNum);
	}
	
	/**
	 * 通过seq查询本次的加油信息
	 * @param seq
	 * @return OilShareFormModel
	 */
	public OilShareFormModel getThisMessage(String seq){
		return oilSearchDao.getThisMessage(seq);
	}
	
	/**
	 * 通过seq查询加油分摊履历表的信息
	 * @param seq
	 * @return List<OilShareTableModel>
	 */
	public List<OilShareTableModel> getShareMessage(String seq){
		return oilSearchDao.getShareMessage(seq);
	}
		
	/**
	 * 通过车牌号查找对应的司机信息
	 * @param plateNum
	 * @return OilSearchModel
	 */ 
	public OilSearchModel findDriver(String plateNum){
		return oilSearchDao.findDriver(plateNum);
	}
	
	/**
	 * 通过司机编码查找对应的车辆信息
	 * @param driverCode
	 * @return OilSearchModel
	 */
	public OilSearchModel findTrailer(String driverCode){
		return oilSearchDao.findTrailer(driverCode);
	}
	
	/**
	 * 查询最新油价
	 * @param fuelType
	 * @param innerFlag
	 * @return double
	 */
	public String getOilPrice(String fuelType,String innerFlag){
		return oilSearchDao.getOilPrice(fuelType, innerFlag);
	}
	
	/**
	 * 查询获取所有订单的运输订单预算-核定-油耗总计
	 * @param driverCode
	 * @return List<FuelFillingDivModel>
	 */
	public List<FuelFillingDivModel> getAllDrv(String lastAddTime, String driverCode){
		return oilSearchDao.getAllDrv(lastAddTime, driverCode);
	}
	
	/**
	 * 通过司机编码查询司机的存油量
	 * @param driverCode
	 * @return String
	 */
	public String getDriStorageOil(String driverCode){
		return oilSearchDao.getDriStorageOil(driverCode);
	}
	
	/**
	 * 添加加油记录信息
	 * @param oilSearchModel
	 */
	public void insertFuelFilling(OilSearchModel oilSearchModel){
		oilSearchDao.insertFuelFilling(oilSearchModel);
		if (oilSearchModel.getAutoFlag()) {
			// 插入关系表
			FuelFillingIdLink idLink = new FuelFillingIdLink();
			idLink.setFuelFillingZgId(StringUtils.toInteger(oilSearchModel.getFuelFillingZgId()));
			idLink.setFuelFillingJgId(StringUtils.toInteger(oilSearchModel.getSeqNo()));
			fuelFillingIdLinkDao.insert(idLink);
		}
		/*oilSearchDao.updateStorageOil(oilSearchModel);*/
	}
	
	/**
	 * 添加实付记录信息
	 * @param payAble
	 */
	public void insertOrdActPayable(ActPayAbleModel payAble){
		oilSearchDao.insertOrdActPayable(payAble);
	}
	
	/**
	 * 添加加油分摊履历信息
	 * @param ffdm
	 */
	public void insertFuelFillingDiv(FuelFillingDivModel ffdm){
		oilSearchDao.insertFuelFillingDiv(ffdm);
	}
	
	/**
	 * 更新加油分摊履历信息
	 */
	public void updateFuelFillingDiv(List<OilShareTableModel> list)throws ValidationException {
		try{
			for(int i=0;i<list.size();i++){
				oilSearchDao.updateFuelFillingDiv(list.get(i));
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new ValidationException("加油分摊记录更新失败！");
		}
	}

	/**
	 * 更新司机的存油量信息
	 * @param oilSearch
	 */
	public void updateStorageOil(OilSearchModel oilSearch){
		oilSearchDao.updateStorageOil(oilSearch);
	}
	
	/**
	 * 同时添加加油记录信息，实付明细记录信息，加油分摊履历信息
	 * @param ffdList
	 * @param apaList
	 * @param oilSearch
	 * @throws ValidationException
	 */
	public void addOil(List<FuelFillingDivModel> ffdList,List<ActPayAbleModel> apaList,OilSearchModel oilSearch)throws ValidationException {
		try{
			oilSearchDao.insertFuelFilling(oilSearch);
			oilSearchDao.updateStorageOil(oilSearch);
			for(int i=0;i<ffdList.size();i++){
				ffdList.get(i).setSeq(oilSearch.getSeqNo());
				oilSearchDao.insertFuelFillingDiv(ffdList.get(i));
				apaList.get(i).setpActDocNo1(oilSearch.getSeqNo());
				oilSearchDao.insertOrdActPayable(apaList.get(i));
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new ValidationException("加油失败！");
		}
	}

	@Transactional(readOnly = false)
	public List<OilSearchExcelModel> findOilMsg(OilSearch conModel) {
		return oilSearchDao.findOilMsg(conModel);
	}

	@Transactional(readOnly = false)
	public String insertOilMsg(List<OilSearchExcelModel> list) {
		String res = null;
		try{
			for(OilSearchExcelModel oilVO:list){
				if(StringUtils.isBlank(oilVO.getInnerFlag())){
					res = MessageUtil.getMessage("oilSearch.import_error1");
				}
				if(StringUtils.isBlank(oilVO.getPlateNum())){
					res = MessageUtil.getMessage("oilSearch.import_error2");
				}
				if(StringUtils.isBlank(oilVO.getDriver())){
					res = MessageUtil.getMessage("oilSearch.import_error3");
				}
				if(StringUtils.isBlank(oilVO.getFuelType())){
					res = MessageUtil.getMessage("oilSearch.import_error4");
				}
				if(StringUtils.isBlank(oilVO.getAddLiters())){
					res = MessageUtil.getMessage("oilSearch.import_error5");
				}
				if(StringUtils.isBlank(oilVO.getOperationTime().toString())){
					res = MessageUtil.getMessage("oilSearch.import_error6");
				}
				if(oilVO.getInnerFlag().equals("油卡")){
					if(StringUtils.isBlank(oilVO.getCardNo())){
						res = MessageUtil.getMessage("oilSearch.import_error7");
					}
					if(StringUtils.isBlank(oilVO.getStation())){
						res = MessageUtil.getMessage("oilSearch.import_error8");
					}
				}
				
			}
				if(res == null){
					for(OilSearchExcelModel oilVO:list){
					if(StringUtils.isBlank(oilVO.getSeqNo())){
						if(oilVO.getInnerFlag().equals("车场")){
							oilVO.setInnerFlag("Y");
						}else{
							oilVO.setInnerFlag("N");
						}
						if(oilVO.getFuelType().equals("柴油")){
							oilVO.setFuelType("CY");
						}else if(oilVO.getFuelType().equals("0号柴油")){
							oilVO.setFuelType("0CY");
						}else if(oilVO.getFuelType().equals("0号柴油自助")){
							oilVO.setFuelType("0CYZZ");
						}else{
							oilVO.setFuelType("");
						}
						String driverCode = oilSearchDao.getDriverCode(oilVO.getDriver());
						if(driverCode == "" ||driverCode == null){
							driverCode = oilSearchDao.getAttachDriverCode(oilVO.getDriver());
						}
						if (StringUtils.isNotBlank(driverCode)) {
							oilVO.setDriver(driverCode);
						}
						oilVO.setCreatePsn(UserUtils.getUser().getId().toString());
						if(StringUtils.isBlank(oilVO.getOperationPsn())){
							oilVO.setOperationPsn(UserUtils.getUser().getId().toString());
						}
						oilSearchDao.insertOilMsg(oilVO);
				    }else{
				    	if(oilVO.getInnerFlag().equals("车场")){
							oilVO.setInnerFlag("Y");
						}else{
							oilVO.setInnerFlag("N");
						}
						if(oilVO.getFuelType().equals("柴油")){
							oilVO.setFuelType("CY");
						}else if(oilVO.getFuelType().equals("0号柴油")){
							oilVO.setFuelType("0CY");
						}else if(oilVO.getFuelType().equals("0号柴油自助")){
							oilVO.setFuelType("0CYZZ");
						}else{
							oilVO.setFuelType("");
						}
						String driverCode = oilSearchDao.getDriverCode(oilVO.getDriver());
						if(driverCode == "" ||driverCode == null){
							driverCode = oilSearchDao.getAttachDriverCode(oilVO.getDriver());
						}
						if (StringUtils.isNotBlank(driverCode)) {
							oilVO.setDriver(driverCode);
						}
						oilVO.setUpdatePsn(UserUtils.getUser().getId().toString());
						oilSearchDao.updateOilMsg(oilVO);
				    }
				}
					res = "success";	
			}
		}catch (ServiceException e) {
			res = e.getMessage();
		}
				
		return res;
	}

	@Transactional(readOnly = false)
	public OilSearchModel findReviseOilMsg(String seqNo) {
		return oilSearchDao.findReviseOilMsg(seqNo);
	}

	/**
	 * 更新修改信息
	 * @param oilSearchModel
	 */
	public void updateFuelFilling(OilSearchModel oilSearchModel) {
		boolean updateFlag = true;
		if (oilSearchModel.getAutoFlag()) {
			// 如果之前不是玖戈，编辑修改为玖戈，则需要新增数据；否则直接更新
			FuelFillingIdLink idLink = fuelFillingIdLinkDao.getByZgId(StringUtils.toInteger(oilSearchModel.getSeqNo()));
			if (idLink != null) {
				oilSearchModel.setSeqNo(StringUtils.toString(idLink.getFuelFillingJgId()));
			} else {
				updateFlag = false;
				oilSearchModel.setFuelFillingZgId(oilSearchModel.getSeqNo());
				oilSearchModel.setSeqNo(null);
				insertFuelFilling(oilSearchModel);
			}
		}
		if (updateFlag) {
			oilSearchDao.updateFuelFilling(oilSearchModel);
		}
	}

	@Transactional(readOnly = false)
	public void importFromZg(List<OilSearchExcelModel> oils) {
		// 批量根据车牌号查询司机信息
		List<String> plateNums = new ArrayList<>();
		for (OilSearchExcelModel oil : oils) {
			plateNums.add(oil.getPlateNum());
		}
		List<OilSearchModel> drivers = oilSearchDao.listDriversByPlateNums(plateNums);
		for (OilSearchExcelModel oil : oils) {
			for (OilSearchModel driver : drivers) {
				if (StringUtils.equals(oil.getPlateNum(), driver.getPlateNum())) {
					oil.setDriver(driver.getDriverCode());
					break;
				}
			}
		}

		for (OilSearchExcelModel oil : oils) {
			if (StringUtils.isBlank(oil.getSeqNo())) {
				oilSearchDao.insertOilMsg(oil);
				// 插入关系表
				insertFuelIdLink(oil);
			} else {
				// 判断是否有此车辆，如果没有，则表示修改为兆冠车辆，玖戈这边数据需要删除
				int cnt = countTrailersByPlateNum(oil.getPlateNum());
				if (cnt == 0) {
					if (org.apache.commons.lang.StringUtils.isNotBlank(oil.getSeqNo())) {
						deleteOil(oil.getSeqNo());
					}

				} else {
					// 如果之前不是玖戈，编辑修改为玖戈，则需要新增数据；否则直接更新
					boolean updateFlag = true;
					FuelFillingIdLink idLink = fuelFillingIdLinkDao.getByZgId(StringUtils.toInteger(oil.getSeqNo()));
					if (idLink != null) {
						oil.setSeqNo(StringUtils.toString(idLink.getFuelFillingJgId()));
					} else {
						updateFlag = false;
						oil.setFuelFillingZgId(oil.getSeqNo());
						oil.setSeqNo(null);
						oilSearchDao.insertOilMsg(oil);
						insertFuelIdLink(oil);
					}

					if (updateFlag) {
						oilSearchDao.updateOilMsg(oil);
					}
				}
			}
		}
	}

	public int countTrailersByPlateNum(String plateNum) {
		return oilSearchDao.countTrailersByPlateNum(plateNum);
	}

	@Transactional(readOnly = false)
	public void deleteOil(String seqNo) {
		FuelFillingIdLink idLink = fuelFillingIdLinkDao.getByZgId(StringUtils.toInteger(seqNo));
		if (idLink != null) {
			String fuelFillingJgId = StringUtils.toString(idLink.getFuelFillingJgId());
			oilSearchDao.deleteFuelFillingIdLink(fuelFillingJgId);
			oilSearchDao.deleteFuelFilling(fuelFillingJgId);
		}
	}

	private void insertFuelIdLink(OilSearchExcelModel oil) {
		FuelFillingIdLink idLink = new FuelFillingIdLink();
		idLink.setFuelFillingZgId(StringUtils.toInteger(oil.getFuelFillingZgId()));
		idLink.setFuelFillingJgId(StringUtils.toInteger(oil.getSeqNo()));
		fuelFillingIdLinkDao.insert(idLink);
	}
}
