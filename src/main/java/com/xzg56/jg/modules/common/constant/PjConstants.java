package com.xzg56.jg.modules.common.constant;

/**
 * 系统常量配置
 * @author ht018
 *
 */
public class PjConstants {
	/**
	 * GPS信息
	 */
	public static final String GPS_USERNAME = "xmzgwl";
	public static final String GPS_PASSWORD = "zgJJZ1234.";
	public static final String GPS_URL = "http://220.162.239.162:9002/GpsReport/services/GpsReportService";
	public static final String GPS_NAMESPACE = "http://webService.sheets.struts.web.gpsreport.fsti.com";
	public static final String GPS_METHOD = "mileSumByCar";
	
	/**
	 * 领导审批页面：领导审批返回信息
	 */
	public static final String APPROVAL_SUCCESS_MSG = "审批成功！";
	public static final String APPROVAL_ERROR_MSG = "审批失败,请查看订单情况！";
	
	/** 加油管理页面：加油返回信息 */
	public static final String SYSTEM_SUCCESS_MSG = "加油成功！";
	public static final String SHARE_SUCCESS_MSG = "加油分摊成功！";
	public static final String SYSTEM_ERROR_MSG = "系统异常！加油失败！";
	public static final String SHARE_ERROR_MSG = "系统异常！加油分摊失败！";
	public static final String CARANDDVR_ERROR_MSG = "司机与车辆不对应！";
	public static final String OIL_ERROR_MSG = "找不到相应的订单，请联系系统管理员！";
	
	/** 客户审批页面：客户审批返回信息 */
	public static final String CUSTOMER_SUCCESS_MSG = "签字确认成功！";
	public static final String CUSTOMER_ERROR_MSG = "签字确认失败！";
	
	/** 车辆管理页面：车辆解绑返回信息 */
	public static final String SPILT_SUCCESS_MSG = "解绑成功！";
	public static final String SPILT_ERROR_MSG = "解绑失败！";
	
	/** 车辆管理页面：车辆绑定返回信息 */
	public static final String BIND_SUCCESS_MSG = "绑定成功！";
	public static final String BIND_ERROR_MSG = "绑定失败！";
	
	/** 确认回场页面：确认回场返回信息 */
	public static final String BACK_SUCCESS_MSG = "确认回场成功！";
	public static final String BACK_ERROR_MSG = "确认回场失败！";
	
	/** 车辆维修页面和车架维修页面和司机休假页面：车辆维修批准提交返回信息 */
	public static final String REPAIR_SUCCESS_MSG = "维修记录成功！";
	public static final String REPAIR_ERROR_MSG = "维修记录失败！";
	public static final String NO_VEHICLE_MSG = "没有此车辆！";
	public static final String NO_FRAME_MSG = "没有此车架！";
	public static final String FIND_ERROR_MSG = "查询出错！";
	public static final String VACATION_SUCCESS_MSG = "休假记录成功！";
	public static final String VACATION_ERROR_MSG = "休假记录失败！";
	public static final String NO_DRIVER_MSG = "没有此司机！";
	public static final String OVER_MAX_PAID_VACATION_MSG = "带薪假一个月不能超过2天！";
	public static final String CANCEL_REPAIR_SUCCESS_MSG = "取消维修成功！";
	public static final String CANCEL_VACATION_SUCCESS_MSG = "取消休假成功！";
	
	/** 凭证上传页面：上传和删除凭证返回信息 */
	public static final String VOUCHER_SUCCESS_MSG = "凭证上传成功！";
	public static final String VOUCHER_ERROR_MSG = "凭证上传失败！";
	public static final String DELETE_SUCCESS_MSG = "凭证删除成功！";
	public static final String DELETE_ERROR_MSG = "凭证删除失败！";
	
	
	//发货状态
	/** 发货状态-创建 */
	public static final String SHIPPING_STATUS_C = "C";
	/** 发货状态-等待 */
	public static final String SHIPPING_STATUS_W = "W";
	/** 发货状态-运输中 */
	public static final String SHIPPING_STATUS_T = "T";
	/** 发货状态-完成 */
	public static final String SHIPPING_STATUS_A = "A";
	
	//分拣状态
	/** 分拣状态 - 已称重 */
	public static final String SORTING_STATUS_W = "W";
	/** 分拣状态 - 已分拣 */
	public static final String SORTING_STATUS_S = "S";
	
	//PDA接口返回信息
	/** PDA接口返回CODE 1 */
	public static final String INTERFACE_RTN_CODE_1 = "1";
	/** PDA接口返回CODE 1 信息 */
	public static final String INTERFACE_RTN_CODE_1_MSG = "无异常。";
	/** PDA接口返回CODE 2 */
	public static final String INTERFACE_RTN_CODE_2 = "2";
	/** PDA接口返回CODE 2 信息 */
	public static final String INTERFACE_RTN_CODE_2_MSG = "部分配送单异常，请参照返回异常配送单信息。";
	/** PDA接口返回CODE -1 */
	public static final String INTERFACE_RTN_CODE_MINUS_1 = "-1";
	/** PDA接口返回CODE -1 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_1_MSG = "必选项参数不能为空！";
	/** PDA接口返回CODE -2 */
	public static final String INTERFACE_RTN_CODE_MINUS_2 = "-2";
	/** PDA接口返回CODE -2 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_2_MSG = "传入的司机代号不存在，请检查！";
	/** PDA接口返回CODE -3 */
	public static final String INTERFACE_RTN_CODE_MINUS_3 = "-3";
	/** PDA接口返回CODE -3 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_3_MSG = "传入的出发冷库不存在，请检查！";
	/** PDA接口返回CODE -4 */
	public static final String INTERFACE_RTN_CODE_MINUS_4 = "-4";
	/** PDA接口返回CODE -4 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_4_MSG = "传入的目的冷库不存在，请检查！";
	/** PDA接口返回CODE -5 */
	public static final String INTERFACE_RTN_CODE_MINUS_5 = "-5";
	/** PDA接口返回CODE -5 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_5_MSG = "传入的所有配送单均无法正常使用！";
	/** PDA接口返回CODE -6 */
	public static final String INTERFACE_RTN_CODE_MINUS_6 = "-6";
	/** PDA接口返回CODE -6 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_6_MSG = "该配送单不存在,请检查！";
	/** PDA接口返回CODE -7 */
	public static final String INTERFACE_RTN_CODE_MINUS_7 = "-7";
	/** PDA接口返回CODE -7 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_7_MSG = "不存在等待生成任务的配送单！";
	/** PDA接口返回CODE -8 */
	public static final String INTERFACE_RTN_CODE_MINUS_8 = "-8";
	/** PDA接口返回CODE -8 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_8_MSG = "重量参数存在异常！";
	/** PDA接口返回CODE -9 */
	public static final String INTERFACE_RTN_CODE_MINUS_9 = "-9";
	/** PDA接口返回CODE -9 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_9_MSG = "该司机对应的冷藏车信息异常，请检查！";
	/** PDA接口返回CODE -10 */
	public static final String INTERFACE_RTN_CODE_MINUS_10 = "-10";
	/** PDA接口返回CODE -10 信息 */
	public static final String INTERFACE_RTN_CODE_MINUS_10_MSG = "该配送单已经被使用，请检查！";
	
	/** 最终用户代号 */
	public static final String END_USER_ID = "END-USER";
	
	// 冷库类型
	/** 类型1 电商冷库 */
	public static final String COLDSTORAGE_TYPE_EC = "1";
	/** 类型2 分拣冷库 */
	public static final String COLDSTORAGE_TYPE_SC = "2";
	/** 类型3 中转冷库 */
	public static final String COLDSTORAGE_TYPE_TF = "3";
	/** 类型4 目的地冷库 */
	public static final String COLDSTORAGE_TYPE_DT = "4";
	/** 类型5 片区冷库 */
	public static final String COLDSTORAGE_TYPE_REGION = "5";
	
	//区域级别
	/** 区域级别 0-国家 */
	public static final int AREA_LEVEL_0 = 0;
	/** 区域级别 1-省 */
	public static final int AREA_LEVEL_1 = 1;
	/** 区域级别 2-市 */
	public static final int AREA_LEVEL_2 = 2;
	/** 区域级别 3-区 */
	public static final int AREA_LEVEL_3 = 3;
	
	//路径级别
	/** 一级路径 */
	public static final String PATH_LEVEL_01 = "01";
	/** 二级路径 */
	public static final String PATH_LEVEL_02 = "02";
	/** 三级路径 */
	public static final String PATH_LEVEL_03 = "03";
	/** 四级路径 */
	public static final String PATH_LEVEL_04 = "04";
	/** 五级路径 */
	public static final String PATH_LEVEL_05 = "05";
	
	//任务级别
	/** 一级任务 */
	public static final String TRANSPORTATION_LEVEL_01 = "01";
	/** 二级任务 */
	public static final String TRANSPORTATION_LEVEL_02 = "02";
	/** 三级任务 */
	public static final String TRANSPORTATION_LEVEL_03 = "03";
	/** 四级任务 */
	public static final String TRANSPORTATION_LEVEL_04 = "04";
	
	/**
	 * message - 更新失败
	 */
	public static final String UPDATE_FAILD = "更新失败";
	/** message - 更新成功*/
	public static final String UPDATE_SUCCESS = "更新成功";
	
	/** V3接口调用失败 */
	public static final String V3_GPS_RTN_ERROR = "0"; // 请求失败
	/** V3接口调用成功 */
	public static final String V3_GPS_RTN_SUCCESS = "1"; // 请求成功
	
	/** 温控状态 -正常*/
	public static final String AREA_TEMP_STATUS_NAL = "1";
	/** 温控状态 -过热*/
	public static final String AREA_TEMP_STATUS_HOT = "2";
	/** 温控状态 -过冷*/
	public static final String AREA_TEMP_STATUS_COLD = "3";
	/** 温控状态 -异常*/
	public static final String AREA_TEMP_STATUS_EXCEPTION = "4";
	/** 所属温区  1*/
	public static final String AREA1_TEMP = "1";
	/** 所属温区  2*/
	public static final String AREA2_TEMP = "2";
	/** 所属温区 3 */
	public static final String AREA3_TEMP = "3";
	/** 所属温区  4*/
	public static final String AREA4_TEMP = "4";

	/**
	 * 框架旧页面使用
	 */
	public static String PAYROLL_TYPE_SALARY = "1"; // 薪水册类别：工资
	public static String PAYROLL_TYPE_BONUS = "2"; // 薪水册类别：年终奖
	public static String PAYROLL_STATUS_UNPUBLISHED = "0"; // 薪水册状态：未公开
	public static String PAYROLL_STATUS_PUBLISHED = "1"; // 薪水册状态：公开
	
	/**系统管理*/
	public static final String ACTIVE_FLAG_TRUE = "1"; //是否启用  是
	public static final String ACTIVE_FLAG_FALSE = "0"; //是否启用  否

	//系统消息 
	public static final String PROCESS_SUCCESS = "操作执行成功!";  
	public static final String ERROR_INSERT_DATA_FAILURE = "数据保存失败!";        
	public static final String ERROR_UPDATE_DATA_FAILURE = "数据更新失败!";        
	public static final String ERROR_DELETE_DATA_FAILURE = "数据删除失败!";       
	public static final String ERROR_SELECT_DATA_FAILURE = "无匹配的相关信息!";    
	public static final String ERROR_NOT_NULL = "不能为空!";                        
	public static final String ERROR_ISNUM = "必须为数字!";                         
	public static final String ERROR = "错误";                                     
	public static final String NOTSELECT = "无可操作信息!";                        
	public static final String INTERFACE_SEND_FAILURE = "短信发送失败!";           
	public static final String TIP_SAVE_SUCCESS = "保存成功!";                    
	public static final String TIP_READ_ONLY = "不可编辑";                        

	//派车单状态  
	/** 已新建/已派单 */
	public static final String DRVORD_STS_NEW_CREATE = "NC"; 
	/** 已承接-司机 */                                
	public static final String DRVORD_STS_UNDERTAKE = "DN";
	/** 已发车 */                           
	public static final String DRVORD_STS_DEPARTING = "EO"; 
	/** 已提箱 */                                              
	public static final String DRVORD_STS_PACKAGE = "PC";   
	/** 已到场装货 */                                          
	public static final String DRVORD_STS_ARRIVE_LOADING = "LDAV";              
	/** 装货完成 */                   
	public static final String DRVORD_STS_FINISH_LOADING = "LDOV";                
	/** 已到场中转 */                     
	public static final String DRVORD_STS_ARRIVE_TRANSFER = "CHAV";               
	/** 已离场中转 */                    
	public static final String DRVORD_STS_LEAVE_TRANSFER = "CHLF";                 
	/** 已到场卸货  */                   
	public static final String DRVORD_STS_ARRIVE_UNLOADING = "ULAV";             
	/** 卸货完成 */                   
	public static final String DRVORD_STS_FINISH_UNLOADING = "ULOV";                
	/** 已还箱 */                    
	public static final String DRVORD_STS_RETURE_BOX = "CB";                       
	/** 已结束-司机确认 */                    
	public static final String DRVORD_STS_DRIVER_OVER = "OVDR";                   
	/** 已结束-车场确认 */             
	public static final String DRVORD_STS_YARD_OVER = "OVTS";                  
	/** 已甩柜 */              
	public static final String DRVORD_STS_FRAME_SWING = "CFOF";                          
	/** 已压架 */                    
	public static final String DRVORD_STS_FRAME_PRESS = "CFBF";                 
	/** 已取消 */                         
	public static final String DRVORD_STS_CANCEL = "CL"; 
	/** 已取架 */                         
	public static final String DRVORD_STS_FRAME_TAKING = "YQJ";                    

	//运输订单状态
	/** 新建 */                        
	public static final String CONTN_FLAG_NEW_CREATE = "0"; 
	/** 已派车 */                                                
	public static final String CONTN_FLAG_DEPARTING = "1";                        
	/** 已部分派车 */                          
	public static final String CONTN_FLAG_PART_DEPARTING = "2";                  
	/** 已提前完成 */                     
	public static final String CONTN_FLAG_ADVANCE_FINISH = "3";                  
	/** 已完成 */                      
	public static final String CONTN_FLAG_FINISH = "4";                           
	/** 已取消 */                           
	public static final String CONTN_FLAG_CANCEL = "5";                           
	/** 已退载 */                          
	public static final String CONTN_FLAG_BACK_LOAD = "6";

	//临时订单状态
	public static final String ORD_INFO_TEMP_ORIGIN = "0";
	public static final String ORD_INFO_TEMP_SUCCESS = "1";
	public static final String ORD_INFO_TEMP_FAILED = "2";

	//派车单节点类型状态
	/** 生成 */                     
	public static final String DRVORD_NOTE_STS_NEW_CREATE = "SC";                  
	/** 承接 */                      
	public static final String DRVORD_NOTE_STS_UNDERTAKE = "CJ";                  
	/** 发车 */                     
	public static final String DRVORD_NOTE_STS_DEPARTING = "FC";                    
	/** 提箱  */                    
	public static final String DRVORD_NOTE_STS_PACKAGE = "TX";                     
	/** 装货 */                    
	public static final String DRVORD_NOTE_STS_LOADING = "ZH";                    
	/** 卸货 */                      
	public static final String DRVORD_NOTE_STS_UNLOADING = "XH";                 
	/** 还箱  */                     
	public static final String DRVORD_NOTE_STS_RETURN_BOX = "HX";                  
	/** 结束 */                    
	public static final String DRVORD_NOTE_STS_END = "JS";                                             

	//车辆状态
	/** 空闲 */
	public static final String TRAILER_STS_FREE = "0";
	/** 使用中 */
	public static final String TRAILER_STS_USING = "1";
	/** 维修中 */
    public static final String TRAILER_STS_REPAIR = "2";

	//车架状态
	/** 空闲 */
	public static final String FRAME_STS_FREE = "0";
	/** 使用中 */ 
	public static final String FRAME_STS_USING = "1";
	/** 维修中 */  
	public static final String FRAME_STS_REPAIR = "2";

	//司机状态
	/** 待命中 */
	public static final String DRIVER_STS_FREEING = "0";
	/** 工作中 */            
	public static final String DRIVER_STS_WORKING = "1";
	/** 请假中 */             
	public static final String DRIVER_STS_LEAVING = "2";

	//压架中状态
	/** 压架中 */
	public static final String CF_PRESS_FLAG_TURE = "Y";
	/** 未压架 */
	public static final String CF_PRESS_FLAG_FLASE = "N";

	//甩架中状态
	/** 甩架中 */
	public static final String CF_SWING_FLAG_TURE = "Y";
	/** 未甩架 */
	public static final String CF_SWING_FLAG_FLASE = "N";
	
	//派车-截取发车时间点
	public static final int SUBSTRING_ELEVEN = 11;
	public static final int SUBSTRING_THIRTEEN = 13;

	//派车单-外排表   派车单状态
	public static final String DRVORD_STATUS_NEW_CREATE = "NC";
	
	//司机请假状态
	/**请假*/
	public static final String DRIVER_HOLIDAY_TRUE = "1";
	/**无请假*/
	public static final String DRIVER_HOLIDAY_FALSE= "2";
	
	//订单是否存在压价、甩架
	/**存在*/
	public static final String CF_FLAG_TRUE = "1";
	/**不存在*/
	public static final String CF_FLAG_FALSE = "2";
	
	//车辆是否绑定司机
	/**是*/
	public static final String TRAILER_BINDING_TRUE = "1";
	/**否*/
	public static final String TRAILER_BINDING_FALSE = "0";
	
	//车辆是否绑定车架号
	/**是*/
	public static final String TRAILER_BINDING_CURRENTCF_TRUE = "1";
	/**否*/
	public static final String TRAILER_BINDING_CURRENTCF_FALSE = "0";
	
	//外排派车单执行完成
	/**是*/
	public static final String DISPATCH_OUT_COMPLETE_TRUE = "1";
	/**否*/
	public static final String DISPATCH_OUT_COMPLETE_FALSE = "0";
	
	//操作间隔时间 zzl
	/**  状态更新间隔不能小于3分钟*/
	public static final String STS_WATI_TIME_NOT_ENOUGH = "状态更新间隔不能小于3分钟";
	/**  状态更新间隔3分钟*/
	public static final Long STS_WATI_TIME = 60*3l;
	
	//是否获取到外排派车单号
	/**否*/
	public static final String DISPATCH_OUT_NO_FALSE = "0";
	
	//出发地编码
	public static final String START_FLACE = "zgCarYard";
	
	//截取当前月份，用于生成派车单规则
	public static final int SUBSTRING_FROM_SEV = 7;
	public static final int SUBSTRING_TO_NIG = 9;
	
	public static final int RESULT_SUCCESS = 1;
	public static final int RESULT_ERROR = -1;
	
	public static final String FLAG_Y = "Y";
	public static final String FLAG_N = "N";
	public static final String FEE_STATUS_0 = "0";
	public static final String FEE_STATUS_1 = "1";

	public interface DRVORD_STS {
		public static final String NO_START = "notStart";
		public static final String RUNNING = "running";
		public static final String FINISHED = "finished";
		public static final String PENDING = "pending";
	}

	public interface ORDER_PICTURE_TYPE {
		public static final String PICK_UP_CONTN = "PICK_UP_CONTN";
		public static final String RETURN_CONTN = "RETURN_CONTN";
		public static final String ABNORMAL = "ABNORMAL";
		public static final String WEIGHT_BILL = "WEIGHT_BILL";
		public static final String EIR = "EIR";
		public static final String CONTN_NO = "CONTN_NO";
		public static final String RECIPIENT = "RECIPIENT";
	}

	public interface DRVORD_GROUP {
		 public static final String DRVORD_GROUP_1 = "1";      //单拖
		 public static final String DRVORD_GROUP_2 = "2";      //双托
		 public static final String DRVORD_GROUP_3 = "3";      //套柜
		 public static final String DRVORD_GROUP_4 = "4";      //甩柜
		 public static final String DRVORD_GROUP_5 = "5";      //甩柜回柜
		 public static final String DRVORD_GROUP_6 = "6";       //回柜
	}

	public interface IO_TYPE {
		public static final String IMPORTED = "0";		//进口
		public static final String EXIT = "1";		//出口
		public static final String OTHER = "2";		//其他
	}

	public interface BINS_TYPE {
		public static final String OUTER = "0";		//外贸
		public static final String INNER = "1";		//内贸
	}

	public interface IO_TYPE_NAME {
		public static final String IMPORTED = "进口";
		public static final String EXIT = "出口";
	}

	public interface DOC_STS {
		public static final String DOC_STS_0 = "0"; //未制作
		public static final String DOC_STS_1 = "1"; //已制作
		public static final String DOC_STS_2 = "2"; //已领取
		public static final String DOC_STS_3 = "3"; //已回收
		public static final String DOC_STS_4 = "4"; //已归档
		public static final String DOC_STS_5 = "5"; //异常归档
		public static final String DOC_STS_6 = "6"; //异常回收
	}

	public interface DOC_LABEL {
		public static final String LABEL_1 = "单证待领取";
		public static final String LABEL_2 = "单证待回收";
		public static final String LABEL_3 = "单证已回收";
		public static final String LABEL_4 = "随柜放置";
		public static final String LABEL_5 = "回收异常";
	}

	public interface DOC_LABEL_COLOR {
		public static final String RED = "red";
		public static final String BLACK = "black";
	}

	public interface ADDRESS_TYPE {
		public static final String ZHD = "010";
		public static final String XHD = "020";
	}

	public interface OUT_ORDER_STS {
		public static final String WAITING = "010";
		public static final String APPROVING = "020";
		public static final String COMPLETED = "030";
		public static final String CANCEL = "040";
	}

	public interface ORD_PAGE_TYPE {
		public static final String created = "1"; //新建
		public static final String snatch = "2"; //抓取
	}

	public interface OUT_STATUS_CODE {
		public static final String UNSCHEDULING = "010"; //未排
		public static final String SCHEDULING = "020"; //已排
	}

	/**
	 * 跑马灯消息头
	 **/
	public static final String YGB_WAIT = "未转单";
	public static final String YGB_WAIT_PATH = "ygbOrder";
	public static final String YGB_WAIT_BOX_ID = "ygbWait";
	public static final String YGB_UNCONTRACT = "未联络客户";
	public static final String YGB_UNCONTRACT_PATH = "conEditContainerNew";
	public static final String YGB_UNCONTRACT_BOX_ID = "ygbUncontract";
	public static final String YLEG_WAIT = "未转单";
	public static final String YLEG_WAIT_PATH = "outorder/ord_manage";
	public static final String YLEG_WAIT_BOX_ID = "ylegWait";
	public static final String YLEG_PLAN = "计划待处理";
	public static final String YLEG_PLAN_PATH = "schedulePlan";
	public static final String YLEG_PLAN_BOX_ID = "ylegPlan";
	public static final String SHIP_OVER_DAY = "(进)已超期";
	public static final String SHIP_OVER_DAY_PATH = "conEditContainerNew";
	public static final String SHIP_OVER_DAY_BOX_ID = "shipOverDay";
	public static final String SHIP_CLOSE_TO_DAY = "(进)临近超期";
	public static final String SHIP_CLOSE_TO_DAY_PATH = "conEditContainerNew";
	public static final String SHIP_CLOSE_TO_DAY_BOX_ID = "shipCloseToDay";
	public static final String SHIP_OVER_CROSS_BOX = "(出)已截箱";
	public static final String SHIP_OVER_CROSS_BOX_PATH = "conEditContainerNew";
	public static final String SHIP_OVER_CROSS_BOX_BOX_ID = "shipOverCrossBox";
	public static final String SHIP_CLOSE_TO_CROSS_BOX = "(出)临近截箱";
	public static final String SHIP_CLOSE_TO_CROSS_BOX_PATH = "conEditContainerNew";
	public static final String SHIP_CLOSE_TO_CROSS_BOX_BOX_ID = "shipCloseToCrossBox";

	public interface ORD_STS_CODE {
		public static final String ORD_STS_CODE_0 = "0";//确定接单	0
		public static final String ORD_STS_CODE_1 = "1";//已派车	1
		public static final String ORD_STS_CODE_2 = "2";//已部分派车	2
		public static final String ORD_STS_CODE_3 = "3";//已提前完成	3
		public static final String ORD_STS_CODE_4 = "4";//已完成	4
		public static final String ORD_STS_CODE_5 = "5";//已取消	5
		public static final String ORD_STS_CODE_6 = "6";//已退载	6
		public static final String ORD_STS_CODE_7 = "7";//暂存	7
	}

	public static final String CONTN_MODIFY_TYPE_PERSON = "1";

	public interface UPDATE_INFO{
		public static final String NEW_ORDER = "新建订单";
		public static final String CANCEL_ORDER = "取消订单";
		public static final String DELETE_ORDER = "删除订单";
		public static final String OVER_ORDER = "提前结束";
	}

	public interface PAYMENT_TYPE {
		public static final String REC = "1";//应收
		public static final String PAY = "2";//应付
	}

	public interface FEE_TYPE {
		public static final String DIRECT = "1";//直接
		public static final String INDIRECT = "2";//间接
	}

	public static final String LINK = "<i class=\"Hui-iconfont\">&#xe67a;</i>";
	public static final String COLON = "：";
	public static final String TRUE = "true";
	public static final String FALSE = "false";
	public static final String YES_CH = "是";
	public static final String NO_CH = "否";
	public static final String EMPTY = "（空）";

	/** 价目 **/
	public static final String PI_YF = "PI_YF";
	public static final String PI_YF_NAME = "运费";
	public static final String PI_CZF = "PI_CZF";
	public static final String PI_CZF_NAME = "超重费";
	public static final String PI_CCF = "PI_CCF";
	public static final String PI_CCF_NAME = "抽成费";
	public static final String PI_TCYF = "PI_TCYF";
	public static final String PI_TCYF_NAME = "趟次油费";
	public static final Double YANG_PI_CCF = 200d;
	public static final String PI_LTSH = "PI_LTSH";
	public static final String PI_LTSH_NAME = "轮胎损耗";
	public static final String PI_SJGZ = "PI_SJGZ";
	public static final String PI_SJGZ_NAME = "司机工资";
	public static final String PI_GXYF = "PI_GXYF";
	public static final String PI_GXYF_NAME = "戈享运费";

	/** 计费类型 **/
	public interface CHARGING_TYPE {
		public static final String CHARGING_TYPE_1 = "1"; // 按柜
		public static final String CHARGING_TYPE_2 = "2"; // 按吨
		public static final String CHARGING_TYPE_3 = "3"; // 按立方
	}

	public interface QUEUE_STATUS {
		public static final String WAITING = "0"; // 待处理
		public static final String SUCCESS = "1"; // 成功
		public static final String FAILURE = "2"; // 失败
	}

	public interface ORD_EXPENSE_ACTION_TYPE {
		public static final String ADD = "0"; // 新增
		public static final String EDIT = "1"; // 编辑
	}

	public interface ATTACHMENT_FUNC_TYPE {
		public static final String ORDER = "1"; // 订单
		public static final String DRIVER = "2"; // 司机信息
		public static final String YARD = "3"; // 堆场计划
	}

	/*采番类型*/
	public class NUMBER_CODE {
		public static final String HEAP_PLAN_IMPORT_HD = "heap_plan_import_hd";
	}

	public class HEAP_PLAN_STATUS {
		public static final String UNTREATED = "010";
		public static final String PROCESSED = "020";
	}

	public class HEAP_PLAN_IMPORT_HD_STATUS {
		public static final String UNTREATED = "010";
		public static final String PROCESSED = "020";
	}

	public static final String HEAP_PLAN = "HEAP_PLAN_STATUS";
	public static final String HEAP_PLAN_IMPORT_HD = "HEAP_PLAN_IMPORT_HD_STATUS";
}
