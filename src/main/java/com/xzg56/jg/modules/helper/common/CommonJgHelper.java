package com.xzg56.jg.modules.helper.common;

import com.xzg56.common.utils.CommonHelper;
import com.xzg56.core.utils.SpringContextHolder;
import com.xzg56.jg.modules.helper.service.DropDownListJgService;

/**
 * 下拉框处理类
 * 例如：
 * @author HT1310HL0227
 *
 */
public class CommonJgHelper extends CommonHelper {
	
    public static String getPiNameList(String parameter){
    	DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
    	String jsonStr = dropDownListService.getPiNameList(parameter);
    	jsonStr = jsonStr.replaceAll("\"","\\\\\"");
    	return jsonStr;
    };

	public static String getOutPiNameList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getOutPiNameList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getInnerPiNameList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getInnerPiNameList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getOutPiName(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getOutPiName();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getPlateNum(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPlateNum();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getInnerPlateNum(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getInnerPlateNum();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getContnOwnerCode(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getContnOwnerCode();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getContnOwnerName(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getContnOwnerName();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getInnerDriverName(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getInnerDriverName();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getAllPlateNum(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getAllPlateNum();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getAllDriverName(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getAllDriverName();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getDriverCode(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDriverCode();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getDriverCodeUnion(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDriverCodeUnion();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getInnerPiName(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getInnerPiName();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getPiCodeOut(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPiCodeOut();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getPiCode(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPiCode();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getProvinceCode(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getProvinceCode();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

    public static String getComList(String parameter){
    	DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
    	String jsonStr = dropDownListService.getComList(parameter);
    	jsonStr = jsonStr.replaceAll("\"","\\\\\"");
    	return jsonStr;
    };

    public static String getCreatePsnList(String parameter){
    	DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
    	String jsonStr = dropDownListService.getCreatePsnList();
    	jsonStr = jsonStr.replaceAll("\"","\\\\\"");
    	return jsonStr;
    };

	/**
	 * 银行账号
	 * @param parameter
	 * @return
	 */
	public static String getAccountNoList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getAccountNoList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	public static String getDownList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDownList(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};
	
	public static String getPlateNumList(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPlateNumList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		
		return jsonStr;
	}
	
	public static String getPiCodeLv1List(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPiCodeLv1List();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};
	
	public static String getFitList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFitList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};
	
	public static String getCusNameList(String parameter){
    	DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
    	String jsonStr = dropDownListService.getCusNameList();
    	jsonStr = jsonStr.replaceAll("\"","\\\\\"");
    	return jsonStr;
    };
    
    public static String getCreatePsnNameList(String parameter){
    	DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
    	String jsonStr = dropDownListService.getCreatePsnNameList();
    	jsonStr = jsonStr.replaceAll("\"","\\\\\"");
    	return jsonStr;
    };
		public static String getReceivePsnNameList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getReceivePsnNameList(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	}

	public static String getImportNoList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getImportNoList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	/**
	 * 提卸箱地点
	 * @param parameter
	 * @return
	 */
	public static String getTxHxAddress(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getTxHxAddress();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	/**
	 * 应收价目
	 * @param parameter
	 * @return
	 */
	public static String getOrPriceItem(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getOrPriceItem(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	/**
	 * 可开票票据
	 * @param parameter
	 * @return
	 */
	public static String getInvoiceTicket(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getInvoiceTicket(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	/**
	 * 箱型
	 * @param parameter
	 * @return
	 */
	public static String getContainerType(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getContainerType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	/**
	 * 代收单
	 * @param parameter
	 * @return
	 */
	public static String getPaymentNoList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPaymentNoList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	/**
	 * 省级地址
	 * @param parameter
	 * @return
	 */
	public static String getProvinceName(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getProviceName();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 外排协议出发地
	 * @param parameter
	 * @return
	 */
	public static String getStartAddrs(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getStartAddrs();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 业务类型
	 * @param parameter
	 * @return
	 */
	public static String getBinsType(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getBinsType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 集装箱价格等级
	 * @param parameter
	 * @return
	 */
	public static String getBfLevelCode(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getBfLevelCode(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 自有车和挂靠车
	 * @param parameter
	 * @return
	 */
	public static String getAllPlateNumList(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getAllPlateNumList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 账单批次
	 * @param parameter
	 * @return
	 */
	public static String getBillBatchNo(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getBillBatchNo();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}
	/**
	 * 往来单位简称
	 * @param parameter
	 * @return
	 */
	public static String getCompanySname(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getCompanySname();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}
	/**
	 * 往来单位全称
	 * @param parameter
	 * @return
	 */
	public static String getCompanyFname(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getCompanyFname();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}
	/**
	 * 往来单位类型
	 * @param parameter
	 * @return
	 */
	public static String getCompanyType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getCompanyType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 是否有效标志
	 * @param parameter
	 * @return
	 */
	public static String getvalidFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getvalidFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 内贸标志
	 * @param parameter
	 * @return
	 */
	public static String getDtFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDtFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 外贸标志
	 * @param parameter
	 * @return
	 */
	public static String getFtFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFtFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 门到门标志
	 * @param parameter
	 * @return
	 */
	public static String getD2dFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getD2dFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 可套柜标志
	 * @param parameter
	 * @return
	 */
	public static String getRoundEnableFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getRoundEnableFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 录单分组标志
	 * @param parameter
	 * @return
	 */
	public static String getOrdInputGroup(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getOrdInputGroup(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 岛内标志
	 * @param parameter
	 * @return
	 */
	public static String getInIslandFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getInIslandFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 预约标志
	 * @param parameter
	 * @return
	 */
	public static String getAppointFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getAppointFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 从业资格证标志
	 * @param parameter
	 * @return
	 */
	public static String getCertificateFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getCertificateFlag(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 危货证标志
	 * @param parameter
	 * @return
	 */
	public static String getDangerousFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDangerousFlag(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 离职标志
	 * @param parameter
	 * @return
	 */
	public static String getQuitFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getQuitFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 价格协议
	 * @param parameter
	 * @return
	 */
	public static String getPriceContractNo(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPriceContractNo(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 运费明细中的价格协议
	 * @param parameter
	 * @return
	 */
	public static String getBFPriceContractNo(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getBFPriceContractNo(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 业务员
	 * @param parameter
	 * @return
	 */
	public static String getSalesmanId(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getSalesmanId();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 权限角色
	 * @param parameter
	 * @return
	 */
	public static String getSysRole(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getSysRole();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}
	/**
	 * 托运人
	 * @param parameter
	 * @return
	 */
	public static String getCustomer(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getCustomer();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}
	/**
	 * 改门点
	 * @param parameter
	 * @return
	 */
	public static String getCustomer2(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getCustomer2();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 车架类型
	 * @param parameter
	 * @return
	 */
	public static String getFrameType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFrameType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 内部编码
	 * @param parameter
	 * @return
	 */
	public static String getFrameCard(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFrameCard();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 车架管理-所属公司
	 * @param parameter
	 * @return
	 */
	public static String getBelongCompy(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getBelongCompy();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 车头车牌号
	 * @param parameter
	 * @return
	 */
	public static String getTruckPlateNo(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getTruckPlateNo();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}
	/**
	 * 码头应付导入批次号
	 * @param parameter
	 * @return
	 */
	public static String getDockCostImportBatchNo(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDockCostImportBatchNo();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 进出口类型
	 * @param parameter
	 * @return
	 */
	public static String getIoType(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getIoType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 打印状态
	 * @param parameter
	 * @return
	 */
	public static String getDocPrintFlag(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDocPrintFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 任务状态
	 * @param parameter
	 * @return
	 */
	public static String getTaskType(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getTaskType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 调度分组
	 * @param parameter
	 * @return
	 */
	public static String getControlGroup(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getControlGroup();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 司机列表
	 * @param parameter
	 * @return
	 */
	public static String getDriverList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDriverList(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	}

	/**
	 * 运费明细中的价格协议(查询用)
	 * @param parameter
	 * @return
	 */
	public static String getAllBFPriceContractNo(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getAllBFPriceContractNo(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");

		return jsonStr;
	}

	/**
	 * 照片审核托运人
	 */
	public static String getCustometPicture(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.customerPicture();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 外部转内部状态
	 */
	public static String getInternalOrderSts(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.internalOrderSts();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 外部转内部处理状态状态
	 */
	public static String getInternalPriceSts(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.internalPriceSts();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 单证类型
	 */
	public static String getOrdDocTypes(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getOrdDocTypes();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 靠泊码头
	 */
	public static String getBerthingDock(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getBerthingDock();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 中文船名
	 */
	public static String getShipNameCN(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getShipNameCN();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 英文船名
	 */
	public static String getShipNameEN(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getShipNameEN();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 方向
	 */
	public static String getDirection(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDirection();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 船东
	 */
	public static String getShipOwnerList(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getShipOwnerList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}


    /**
     * 挂靠司机
     */
    public static String getInnerAttachDriverName(String parameter) {
        DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
        String jsonStr = dropDownListService.getInnerAttachDriverName();
        jsonStr = jsonStr.replaceAll("\"","\\\\\"");
        return  jsonStr;
    }

	/**
	 * 司机注册状态
	 */
	public static String getRegistrationSts(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getRegistrationSts();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 注册类型
	 */
	public static String getDriverType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getDriverType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 运柜宝
	 */
	public static String getYgbCustomerValue(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getYgbCustomerValue();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 盘点状态
	 */
	public static String getStocktakingSts(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getStocktakingSts();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 特殊箱型
	 */
	public static String getSpecialContnType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getSpecialContnType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 港口
	 */
	public static String getPortCity(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPortCity();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 环球标志
	 */
	public static String getOverlapCabinetAddFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getOverlapCabinetAddFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 是否补公里标志
	 */
	public static String getHqFlag(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getHqFlag();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * Gps车牌号
	 */
	public static String getGpsPlateNum(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getGpsPlateNum();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 单位类型
	 */
	public static String getOperationType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getOperationType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 外排司机
	 */
	public static String getDriverOut(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.driverOut();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 外排车牌号
	 */
	public static String getPlateNumOut(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.plateNumOut();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 云当预转订单状态
	 */
	public static String getPreOrderSts(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.preOrderSts();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 箱主
	 */
	public static String getContnOwnerList(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getContnOwnerList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	public static String getComListToOperateFee(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getComListToOperateFee(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	};

	/**
	 * 费用模板编码
	 */
	public static String getFeeExcelCodeList(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFeeExcelList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 费用模板名称
	 */
	public static String getFeeExcelNameList(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFeeExcelNameList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 反馈状态
	 */
	public static String getFeedbackSts(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFeedbackSts();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 反馈来源
	 */
	public static String getFeedbackFrom(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFeedbackFrom();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 车辆轮轴类型
	 */
	public static String getTWheelType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getTWheelType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 车辆类型
	 */
	public static String getTrailerType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getTrailerType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 燃油类型
	 */
	public static String getFuelType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFuelType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 油耗类型
	 */
	public static String getOilComspType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getOilComspType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 * 百公里油耗表车牌号
	 */
	public static String getTrailerStdOilPlateNum(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getTrailerStdOilPlateNum();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *货物
	 */
	public static String getGoodsType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getGoodsType(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *路线类型
	 */
	public static String getRouterType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getRouterType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *计费模式
	 */
	public static String getChargingType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getChargingType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *车牌号
	 */
	public static String getPlateNums(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPlateNums();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *车架
	 */
	public static String getFrames(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getFrames();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *运输方式
	 */
	public static String getTransportType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getTransportType();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *价目
	 */
	public static String getPriceItems(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPriceItems();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *往来单位
	 */
	public static String getRelatedCompy(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getRelatedCompy();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *根据类型获取往来单位
	 */
	public static String getRelatedCompysByType(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getRelatedCompysByType(parameter);
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *获取装卸地址集合
	 */
	public static String getZxAddresList(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getZxAddresList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *获取价格协议集合
	 */
	public static String getPriceContracts(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getPriceContracts();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	/**
	 *获取箱主集合
	 */
	public static String getContnOwner(String parameter) {
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getContnOwner();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return  jsonStr;
	}

	public static String getExtraWorkList(String parameter){
		DropDownListJgService dropDownListService = SpringContextHolder.getBean(DropDownListJgService.class);
		String jsonStr = dropDownListService.getExtraWorkList();
		jsonStr = jsonStr.replaceAll("\"","\\\\\"");
		return jsonStr;
	}
}
