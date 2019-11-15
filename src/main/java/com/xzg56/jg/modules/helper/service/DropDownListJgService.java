package com.xzg56.jg.modules.helper.service;

import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSON;
import com.xzg56.common.module.sys.persistence.dao.CommonQueryDao;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.utility.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true)
public class DropDownListJgService {
	@Autowired
	private CommonQueryDao commonQueryDao;
	
	public String getPiNameList(String para){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = "select PI_CODE as value,PI_NAME as text from mst_price_item ";

	    if(StringUtils.isNotBlank(para)) {
	    	sql += "where delete_flag='N'";
		}

		parameter.put("sql",sql);
	    List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getOutPiNameList(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select PI_CODE_OUT as value,PI_NAME as text from mst_price_item_out");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getOutPiName(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select PI_NAME as value,PI_NAME as text from mst_price_item_out");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getPlateNum(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select PLATE_NUM as value,PLATE_NUM as text from mst_trailer");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getInnerPlateNum(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select PLATE_NUM as value,PLATE_NUM as text from mst_trailer where VALID_FLAG = 'Y'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getContnOwnerCode(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select CONTN_OWNER_CODE as value,CONTN_OWNER_CODE as text from mst_contn_owner");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getContnOwnerName(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select CONTN_OWNER_NAME as value,CONTN_OWNER_NAME as text from mst_contn_owner");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getInnerDriverName(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select DRIVER_CODE as value,DRIVER_NAME as text from mst_driver");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getAllPlateNum(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT mt.PLATE_NUM AS value,mt.PLATE_NUM AS text FROM mst_trailer mt WHERE mt.VALID_FLAG = 'Y'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getAllDriverName(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select md.DRIVER_CODE as value,md.DRIVER_NAME as text from mst_driver md WHERE md.QUIT_FLAG = 'N'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getDriverCodeUnion(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "(select md.DRIVER_CODE as value,md.DRIVER_NAME as text from mst_driver md where (select count(1) as num from salary_invisable_list sil where sil.driver_code = md.DRIVER_CODE AND sil.delete_flag = 'N') = 0 and md.QUIT_FLAG = 'N')");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getDriverCode(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select md.DRIVER_CODE as value,md.DRIVER_NAME as text from mst_driver md where md.QUIT_FLAG = 'N'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getPiCodeOut(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select PI_CODE_OUT as value,PI_CODE_OUT as text from mst_price_item_out");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getProvinceCode(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select CODE as value,NAME as text from mst_std_address where PCODE = 'NULL' OR PCODE IS NULL");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getInnerPiName(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select PI_NAME as value,PI_NAME as text from mst_price_item");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getInnerPiNameList(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select PI_CODE as value,PI_NAME as text from mst_price_item");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getPiCode(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select PI_CODE as value,PI_CODE as text from mst_price_item");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getComList(String params) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
	    parameter.put("sql", "select RELATED_COMPY_CODE as value,COMPY_SNAME as text from mst_related_compy");
	    List<Map<String, String>> list  = commonQueryDao.query(parameter);
	    if(StringUtils.isNotBlank(params)) {
			Map<String, String> extra = JSON.parseObject(params, Map.class);
			list.add(0, extra);
		}
		return JSONUtils.toJSONString(list);
	}

	public String getCreatePsnList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
	    parameter.put("sql", "SELECT id as value, name as text FROM t_user where user_type = '010' ORDER BY id");
	    List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getAccountNoList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select ACCOUNT_NO as value,CONCAT(BANK_BRANCH,'_',ACCOUNT_NO) as text from mst_bank_account");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getDownList(String params) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String[] strParams = params.split("&");
		parameter.put("sql", "select value as value,label as text from t_dict where active_flag='1' " +
				"and groupno ='" + strParams[0] + "' order by order_index");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		if(strParams.length > 1 && StringUtils.isNotBlank(strParams[1])) {
			Map<String, String> extra = JSON.parseObject(strParams[1], Map.class);
			list.add(0, extra);
		}
		return JSONUtils.toJSONString(list);
	}
	
	public String getPlateNumList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT PLATE_NUM AS text, GPS_PLATE_NUM AS value FROM mst_trailer");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		
		return JSONUtils.toJSONString(list);
	}

	public String getPiCodeLv1List() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select pi_code as value,pi_name as text from mst_price_item_lvl1");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getFitList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
	    parameter.put("sql", "SELECT MF.ID AS value,CONCAT(MF.NAME,',',MF.PHONE1) AS text FROM MST_FIT MF");
	    List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
 
	public String getCusNameList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
	    parameter.put("sql", "SELECT RELATED_COMPY_CODE AS value,COMPY_SNAME AS text FROM MST_RELATED_COMPY "
	    		+ "WHERE RELATED_COMPY_TYPE IN('C','P') ORDER BY RELATED_COMPY_CODE");
	    List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getCreatePsnNameList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
	    parameter.put("sql", "SELECT NAME AS value,NAME AS text FROM T_USER");
	    List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
	public String getReceivePsnNameList(String param){
		Map<String,Object> parameter =  new HashMap<String,Object>();
				parameter.put("sql", "SELECT M.value , M.text FROM ( SELECT MD.USER_ID AS value , MD.DRIVER_NAME AS text FROM mst_driver MD WHERE MD.QUIT_FLAG = 'N' AND MD.USER_ID IS NOT NULL) M ORDER BY CONVERT( M.text	 USING gbk)");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		if(StringUtils.isNotBlank(param)){
			Map<String, String> extra = JSON.parseObject(param, Map.class);
			list.add(0, extra);
		}
		return JSONUtils.toJSONString(list);
	}

    public String getImportNoList() {
        Map<String,Object> parameter =  new HashMap<String,Object>();
        parameter.put("sql", "SELECT DISTINCT IMPORT_NO AS value ,IMPORT_NO AS text FROM IMPORT_FEE_CHECK" +
				" ORDER BY IMPORT_NO DESC");
        List<Map<String, String>> list  = commonQueryDao.query(parameter);
        return JSONUtils.toJSONString(list);
    }

	public String getTxHxAddress() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT RELATED_COMPY_CODE AS value,COMPY_SNAME AS text FROM MST_RELATED_COMPY "
				+ "WHERE RELATED_COMPY_TYPE IN('Y','D') ORDER BY RELATED_COMPY_CODE");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

    public String getOrPriceItem(String para) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = "SELECT PI_CODE AS value,PI_NAME AS text FROM MST_PRICE_ITEM "
				+ "WHERE RECEIVABLE_FLAG ='Y' AND PRICE_DIRECT_FLAG = 'Y'";
		if(StringUtils.isNotBlank(para)) {
			sql += " AND DELETE_FLAG = 'N'";
		}
		parameter.put("sql", sql);
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
    }

    public String getInvoiceTicket(String para) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = "SELECT INVOICE_NO AS value,INVOICE_NO AS text FROM INVOICE " +
				"WHERE INVOICE_TYPE ='1' AND invoice_issue_need_flag = 'Y' ";
		if(StringUtils.isNotBlank(para))
			sql += "AND (AMOUNT-issue_amount)>0";
		parameter.put("sql", sql);
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
    }

	public String getPaymentNoList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select payment_no as value, payment_no as text from indirect_receivable " +
				"where payment_no is not null and payment_amount>0 order by payment_no desc");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
	public String getProviceName(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT S.`NAME` AS text, S.CODE AS value FROM MST_STD_ADDRESS S WHERE ISNULL(S.PCODE) ORDER BY S.CODE");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
	public String getStartAddrs(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'DRV_OUT_SAL_CODE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
	public String getBinsType(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'BINS_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
	public String getBfLevelCode(String para){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'BF_LEVEL_CODE'";
		if(StringUtils.isNotBlank(para)){
			sql += " and value in ('20GP','40GP')";
		}
		parameter.put("sql", sql);
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getContainerType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select value as value ,label as text from t_dict  " +
				"where groupno='CONTAINER_TYPE' AND active_flag='1'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getAllPlateNumList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT  PLATE_NUM  AS value " +
				",PLATE_NUM  AS text " +
				"FROM  MST_TRAILER ");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

    public String getBillBatchNo() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT   MAX(BB.bill_batch_no)  AS value " +
				",MAX(BB.bill_batch_no)  AS text  " +
				"FROM  bill_batch BB " +
				"LEFT JOIN bill_header BH on BB.id = BH.bill_batch_id " +
				"WHERE BH.bill_status IN('0','1') " +
				"GROUP BY BB.bill_batch_no " +
				"order by BB.id desc");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
    }

	public String getCompanySname() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT COMPY_SNAME AS text,RELATED_COMPY_CODE AS value FROM MST_RELATED_COMPY"
				+ " WHERE IFNULL(COMPY_SNAME,'') != '' and (RELATED_COMPY_TYPE = 'C' OR RELATED_COMPY_TYPE ='P')");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getCompanyFname() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT COMPY_FNAME AS text,RELATED_COMPY_CODE AS value FROM MST_RELATED_COMPY"
				+ " WHERE IFNULL(COMPY_FNAME,'') != ''");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getCompanyType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'RELATED_COMPY_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getvalidFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'VALID_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getDtFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'DT_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getFtFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'FT_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getD2dFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'D2D_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getRoundEnableFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'ROUND_ENABLE_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getOrdInputGroup(String param) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM SYS_DICT SD WHERE SD.groupno = 'ORD_INPUT_GROUP'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		if(StringUtils.isNotBlank(param)){
			Map<String, String> extra = JSON.parseObject(param, Map.class);
			list.add(0, extra);
		}
		return JSONUtils.toJSONString(list);
	}

	public String getInIslandFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'IN_ISLAND_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getAppointFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'APPOINT_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getCertificateFlag(String param) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'CERTIFICATE_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		if(StringUtils.isNotBlank(param)){
			Map<String, String> extra = JSON.parseObject(param, Map.class);
			list.add(0, extra);
		}
		return JSONUtils.toJSONString(list);
	}
	public String getDangerousFlag(String param) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'DANGEROUS_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		if(StringUtils.isNotBlank(param)){
			Map<String, String> extra = JSON.parseObject(param, Map.class);
			list.add(0, extra);
		}
		return JSONUtils.toJSONString(list);
	}

	public String getQuitFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT SD.LABEL AS text ,SD.VALUE AS value FROM T_DICT SD WHERE SD.groupno = 'QUIT_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getSalesmanId() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT id as value, name as text FROM t_user where user_type = '010' ORDER BY id");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
	public String getSysRole() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select cn_name as text , id as value from t_role");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
	public String getCustomer() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT CONCAT_WS('',OH.`CUS_CODE`,OH.`CUS_FIT_ID`) AS value,"
				+ "CONCAT_WS('',CUS.`COMPY_SNAME`,CUSF.`NAME`) AS text"
				+ " FROM `ord_header` OH INNER JOIN `mst_related_compy` CUS ON CUS.`RELATED_COMPY_CODE` = OH.`CUS_CODE`"
				+ " LEFT JOIN `mst_fit` CUSF ON CUSF.`ID` = OH.`CUS_FIT_ID`"
				+ " WHERE 1=1 AND OH.`ORD_STS_CODE` IN ('1', '4')"
				+ " GROUP BY OH.`CUS_CODE`,OH.`CUS_FIT_ID` ORDER BY CONVERT( text USING gbk)");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getCustomer2() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT CONCAT_WS('',OH.`SECOND_P_COMPY_CODE`,OH.`SECOND_P_FIT_ID`) AS value,"
				+ " CONCAT_WS('',SED.`COMPY_SNAME`,SEDF.`NAME`) AS text"
				+ " FROM `ord_header` OH LEFT JOIN `mst_related_compy` SED ON SED.`RELATED_COMPY_CODE` = OH.`SECOND_P_COMPY_CODE`"
				+ " LEFT JOIN `mst_fit` SEDF ON SEDF.`ID` = OH.`SECOND_P_FIT_ID` WHERE 1=1 AND OH.`ORD_STS_CODE` IN ('1', '4')"
				+ " AND OH.`SECOND_P_COMPY_CODE` IS NOT NULL AND SED.`COMPY_SNAME`IS NOT NULL GROUP BY"
				+ " OH.`SECOND_P_COMPY_CODE`,OH.`SECOND_P_FIT_ID`,value ORDER BY CONVERT( text USING gbk)");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

    public String getPriceContractNo(String para) {
        Map<String,Object> parameter =  new HashMap<String,Object>();
        String sql = "select  pc.PRICE_CONTRACT_NO as value ,pc.CONTRACT_NAME as text from price_contract pc where pc.SETTLEMENT_TYPE != '3' and pc.VALID_FLAG = 'Y' and pc.PRICE_CONTRACT_NO != 'HT000014'";
        if(StringUtils.equals(BizFcConstants.YES,para)){
        	sql += " and (pc.VALID_FLAG = 'Y' AND PC.EFFECT_START_TIME <= DATE_FORMAT(now(),'%Y-%m-%d') " +
					"and PC.EFFECT_END_TIME >= DATE_FORMAT(now(),'%Y-%m-%d'))";
		}
        parameter.put("sql", sql);
        List<Map<String, String>> list  = commonQueryDao.query(parameter);
        return JSONUtils.toJSONString(list);
    }

	public String getBFPriceContractNo(String para) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = "select  pc.PRICE_CONTRACT_NO as value ,pc.CONTRACT_NAME as text from price_contract pc where pc.SETTLEMENT_TYPE != '3'and pc.VALID_FLAG = 'Y'";
		if(StringUtils.equals(BizFcConstants.YES,para)){
			sql += " and (pc.VALID_FLAG = 'Y' AND PC.EFFECT_START_TIME <= DATE_FORMAT(now(),'%Y-%m-%d') " +
					"and PC.EFFECT_END_TIME >= DATE_FORMAT(now(),'%Y-%m-%d'))";
		}
		parameter.put("sql", sql);
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getFrameType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT T.ID AS value, T.TYPE_NAME AS text FROM MST_FRAME_TYPE T");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getFrameCard() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT T.ID AS value, T.CARD_NO AS text FROM MST_FRAME_CARD T");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getBelongCompy() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT T.RELATED_COMPY_CODE AS value, T.COMPY_SNAME AS text " +
				"FROM MST_RELATED_COMPY T WHERE T.RELATED_COMPY_TYPE='ADL' OR T.RELATED_COMPY_CODE='OG000000'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getTruckPlateNo() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT MT.PLATE_NUM AS value, MT.PLATE_NUM AS text FROM MST_TRAILER MT WHERE MT.VALID_FLAG = 'Y' ORDER BY TRAILER_BELONG_TYPE ASC");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

    public String getDockCostImportBatchNo() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = "select t.IMPORT_BATCH_NO AS value,t.IMPORT_BATCH_NO AS text " +
				"from import_excel_batch t " +
				"order by t.IMPORT_BATCH_NO desc";
		parameter.put("sql", sql);
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
    }

	public String getIoType(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'IO_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getDocPrintFlag() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'DOC_PRINT_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getTaskType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'ORD_STS_CODE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getControlGroup() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'CONTROL_GROUP'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getDriverList(String param){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT M.value , M.text FROM ( SELECT MD.DRIVER_CODE AS value , MD.DRIVER_NAME AS text FROM mst_driver MD WHERE MD.QUIT_FLAG = 'N') M ORDER BY CONVERT( M.text	 USING gbk)");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		if(StringUtils.isNotBlank(param)){
			Map<String, String> extra = JSON.parseObject(param, Map.class);
			list.add(0, extra);
		}
		return JSONUtils.toJSONString(list);
	}

	public String getAllBFPriceContractNo(String para) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = "select  pc.PRICE_CONTRACT_NO as value ,pc.CONTRACT_NAME as text from price_contract pc where pc.SETTLEMENT_TYPE != '3'";
		parameter.put("sql", sql);
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String customerPicture() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = "SELECT OH.`CUS_CODE` AS value," +
				"CUS.`COMPY_SNAME` AS text " +
				"FROM `ord_header` OH " +
				"INNER JOIN `mst_related_compy` CUS ON CUS.`RELATED_COMPY_CODE` = OH.`CUS_CODE` " +
				"WHERE 1 = 1 " +
				"AND OH.`ORD_STS_CODE` IN ('1', '4') " +
				"GROUP BY OH.`CUS_CODE` " +
				"ORDER BY CONVERT (text USING gbk)";
		parameter.put("sql", sql);
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

    public String internalOrderSts() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'INTERNAL_ORDER_STS'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
    }

	public String internalPriceSts() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'INTERNAL_PRICE_STS'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}


	public String getOrdDocTypes() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'ORD_DOC_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getDirection() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'DIRECTION_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getShipOwnerList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT MRC.COMPY_SNAME AS text, MRC.RELATED_COMPY_CODE AS value FROM MST_RELATED_COMPY MRC INNER JOIN MST_SHIP_OWNER MSO ON MRC.RELATED_COMPY_CODE = MSO.SHIP_OWNER_CODE WHERE MRC.RELATED_COMPY_TYPE = 'S'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getInnerAttachDriverName(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "select DRIVER_CODE as value,DRIVER_NAME as text from mst_driver where driver_type = '1'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getRegistrationSts(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT `value` AS value ,label AS text FROM t_dict WHERE groupno = 'REGISTRATION_STS'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getDriverType(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT `value` AS value ,label AS text FROM t_dict WHERE groupno = 'REGISTRATION_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}


	public String getBerthingDock() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT COMPY_SNAME AS text,RELATED_COMPY_CODE AS value FROM MST_RELATED_COMPY WHERE RELATED_COMPY_TYPE = 'D'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getShipNameCN() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT SHIP_NAME_CN AS text,ID AS value FROM MST_SHIP LIMIT 10");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getShipNameEN() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT SHIP_NAME_EN AS text,ID AS value FROM MST_SHIP LIMIT 10");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getYgbCustomerValue(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT customer_id AS value ,customer_name AS text FROM ygb_customer");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getStocktakingSts(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT `value` AS value ,label AS text FROM t_dict WHERE groupno = 'FRAME_STOCKTAKING_STS'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getSpecialContnType(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT label AS text ,value AS value FROM t_dict where groupno = 'SPECIAL_CONTN_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

    public String getPortCity(){
        Map<String,Object> parameter =  new HashMap<String,Object>();
        parameter.put("sql", "SELECT label AS text ,value AS value FROM t_dict where groupno = 'PORT_CITY'");
        List<Map<String, String>> list  = commonQueryDao.query(parameter);
        return JSONUtils.toJSONString(list);
    }

    public String getHqFlag(){
        Map<String,Object> parameter =  new HashMap<String,Object>();
        parameter.put("sql", "SELECT label AS text ,value AS value FROM t_dict where groupno = 'HQ_FLAG'");
        List<Map<String, String>> list  = commonQueryDao.query(parameter);
        return JSONUtils.toJSONString(list);
    }

	public String getOverlapCabinetAddFlag(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT label AS text ,value AS value FROM t_dict where groupno = 'OVERLAP_CABINET_ADD_FLAG'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getGpsPlateNum(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT PLATE_NUM as text, PLATE_NUM as value FROM MST_TRAILER WHERE 1=1 AND GET_GPS_FLAG = 'Y' ORDER BY PLATE_NUM");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getOperationType(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT label AS text ,value AS value FROM t_dict where groupno = 'OPERATION_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String driverOut(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT DISTINCT driver_name AS text, user_id AS value FROM drvord_outer WHERE IFNULL(driver_name, '') != ''");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String plateNumOut(){
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT DISTINCT plate_num AS text, plate_num AS value FROM drvord_outer WHERE IFNULL(plate_num, '') != ''");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String preOrderSts() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'PRE_ORDER_STS'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getContnOwnerList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT  ID AS value ,CONTN_OWNER_NAME AS text FROM MST_CONTN_OWNER MCO");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}


	public String getComListToOperateFee(String params) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT MRC.`RELATED_COMPY_CODE` as value ,MRC.`COMPY_SNAME`  as text " +
				"FROM   `mst_related_compy` MRC " +
				"WHERE MRC.`RELATED_COMPY_TYPE` IN ('C','D','S','P','Y','DR','ADR') AND MRC.ACTIVE_FLAG = 'Y' " +
				"AND MRC.`RELATED_COMPY_CODE` !='OG000000' " +
				"ORDER BY MRC.`RELATED_COMPY_TYPE` DESC ,MRC.`RELATED_COMPY_CODE`");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		if(StringUtils.isNotBlank(params)) {
			Map<String, String> extra = JSON.parseObject(params, Map.class);
			list.add(0, extra);
		}
		return JSONUtils.toJSONString(list);
	}

	public String getFeeExcelList() {
		Map<String, Object> parameter = new HashMap();
		parameter.put("sql", "SELECT  EXCEL_TEPL_CODE AS value, EXCEL_TEPL_CODE AS text FROM mst_fee_excel_tepl");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getFeeExcelNameList() {
		Map<String, Object> parameter = new HashMap();
		parameter.put("sql", "SELECT  MFE.EXCEL_TEPL_CODE AS value,MFE.EXCEL_TEPL_NAME AS text FROM mst_fee_excel_tepl MFE");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getFeedbackSts() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'FEEDBACK_STS'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getFeedbackFrom() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM T_DICT WHERE GROUPNO = 'FEEDBACK_FROM'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getTWheelType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM t_dict WHERE GROUPNO = 'CAR'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getTrailerType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM t_dict WHERE GROUPNO = 'TRAILER_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getFuelType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM t_dict WHERE GROUPNO = 'OIL_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

    public String getOilComspType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM t_dict WHERE GROUPNO = 'oilComspType'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
    }

	public String getTrailerStdOilPlateNum() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT PLATE_NUM AS text,PLATE_NUM AS value FROM mst_trailer_std_oil");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getGoodsType(String para) {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		String sql = " SELECT GOODS_NAME AS value, GOODS_NAME AS text FROM mst_goods where 1=1";
		if(StringUtils.equals(para,"1")){
			sql += " and INTER_EXTER_GOODS = '1'";
		}
		if(StringUtils.equals(para,"2")){
			sql += " and INTER_EXTER_GOODS = '2'";
		}
		parameter.put("sql", sql);
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getRouterType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT ROUTE_LOCATION_NAME AS value, ROUTE_LOCATION_NAME AS text FROM mst_route_location");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getChargingType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM t_dict WHERE GROUPNO = 'CHARGING_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}


	public String getPlateNums() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT PLATE_NUM AS text, PLATE_NUM AS value FROM mst_trailer");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}


	public String getFrames() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT frame_card_id AS text,id AS value FROM mst_truck_frame");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getPriceItems() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT PI_CODE AS value,PI_NAME AS text FROM mst_price_item");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getTransportType() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", " SELECT LABEL AS text,VALUE AS value FROM t_dict WHERE GROUPNO = 'TRANSPORT_TYPE'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getRelatedCompy() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT COMPY_SNAME AS text,RELATED_COMPY_CODE AS value FROM MST_RELATED_COMPY"
				+ " WHERE IFNULL(COMPY_SNAME,'') != ''");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getRelatedCompysByType(String realtedCompyType) {
		String[] realtedCompyTypes = realtedCompyType.split(",");
		List<String> types = new ArrayList<>();
		for (String type : realtedCompyTypes) {
			StringBuffer sb = new StringBuffer();
			types.add(sb.append("'").append(type).append("'").toString());
		}
		realtedCompyType = StringUtils.join(types.toArray(), ",");
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT COMPY_SNAME AS text,RELATED_COMPY_CODE AS value FROM MST_RELATED_COMPY"
				+ " WHERE IFNULL(COMPY_SNAME,'') != '' and related_compy_type in(" + realtedCompyType + ")");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getZxAddresList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT name AS text,id AS value FROM MST_ZX_ADDRESS where deleted_flag != 'Y'");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getPriceContracts() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT contract_name AS text,price_contract_no AS value FROM price_contract");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getContnOwner() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT CONTN_OWNER_NAME AS text,ID AS value FROM mst_contn_owner");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}

	public String getExtraWorkList() {
		Map<String,Object> parameter =  new HashMap<String,Object>();
		parameter.put("sql", "SELECT EXTRA_WORK_NAME AS text,ID AS value FROM mst_extra_work_price_item");
		List<Map<String, String>> list  = commonQueryDao.query(parameter);
		return JSONUtils.toJSONString(list);
	}
}
