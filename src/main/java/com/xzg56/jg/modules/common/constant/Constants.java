package com.xzg56.jg.modules.common.constant;

/**
 * Created by zwm on 2018/1/31.
 */
public class Constants {

    /* 车架状态 */
    public interface TRUCK_FRAME_STATUS_CODE {
        public static final String INUSE = "INUSE";
        public static final String UNUSED  = "UNUSED";
        public static final String SCRAP = "SCRAP";
    }

    /* 换架原因 */
    public interface FRAME_CHANGE_REASON {
        public static final String CREATE = "新增";
        public static final String UPDATE = "换架";
        public static final String UNBIND  = "解绑";
        public static final String SCRAP = "报废";
    }

    /* 内部编码状态 */
    public interface FRAME_CARD_STATUS_CODE {
        public static final String INUSE = "INUSE";
        public static final String UNUSED  = "UNUSED";
        public static final String SCRAP = "SCRAP";
    }

    /* 车架状态 */
    public static final String TRUCK_FRAME_STATUS_GROUP_NO = "TRUCK_FRAME_STATUS";
    /* 内部编码状态 */
    public static final String FRAME_CARD_STATUS_GROUP_NO = "FRAME_CARD_STATUS";
    /* 套牌拼接字符 */
    public static final String TAOPAI_CHAR = "T";

    /* 车架地址 */
    public interface TRUCK_FRAME_ADDRESS {
        public static final String TRAILER = "挂车";
        public static final String CAR_YARD  = "车场";
    }

    /* 车架盘点状态 */
    public interface FRAME_STOCKTAKING_STS {
        public static final String IN_STOCKTAKING = "010";
        public static final String AT_STOCKTAKING = "020";
        public static final String ON_STOCKTAKING = "030";
    }

    /*车架盘点状态*/
    public static final String FRAME_STOCKTAKING_STS_GROUP_NO = "FRAME_STOCKTAKING_STS";

    /*盘点状态*/
    public static final String STOCKTAKING_STS_GROUP_NO = "STOCKTAKING_STS";


    /* 车架报修状态 */
    public static final String TRUCK_FRAME_REPAIR_STATUS_GROUP_NO = "TRUCK_FRAME_REPAIR_STATUS";
    /* 车架报修类型 */
    public static final String TRUCK_FRAME_REPAIR_TYPE_GROUP_NO = "TRUCK_FRAME_REPAIR_TYPE";

    /* 车架报修状态 */
    public interface TRUCK_FRAME_REPAIR_STATUS {
        public static final String APPLY    = "010";
        public static final String REPAIR   = "020";
        public static final String COMPLETE = "030";
        public static final String CANCEL   = "040";
        public static final String OVERRULE = "050";
    }

    /* 维修图片 */
    public interface FRAME_REPAIR_ATTACHMENT_TYPE {
        public static final String TROUBLE  = "010";
        public static final String SPOT     = "020";
        public static final String INVOICE  = "030";
    }

    /* 报修发起类型 */
    public static final String TRUCK_FRAME_REPAIR_APPLY_FROM = "FRAME_REPAIR_APPLY_FROM";
    public interface FRAME_REPAIR_APPLY_FROM {
        public static final String DRIVER = "010";
        public static final String ADMIN  = "020";
    }

    /*业务类型*/
    public static final String BINS_TYPE = "BINS_TYPE";

    /*进出口类型*/
    public static final String IO_TYPE = "IO_TYPE";

    public static final String COMMA = "，";
    public static final String SPACE = " ";

    public interface ADRS_MODIFY_TABLE_TYPE {
        public static final String TRAILER = "010";
        public static final String TRUCK_FRAME = "020";
        public static final String CONTN = "030";
    }

    /*业务类型*/
    public interface BUSINESS_TYPE {
        public static final String SELF_TRANSPORT = "1";//自有运输
        public static final String IMPORT = "2";//进口
        public static final String MD_EXPORT = "3";//明达出口柜
        public static final String MD_BORROW_CONTN = "4";//明达借柜
    }

    /*默认语言*/
    public static final String DEFAULT_LANGUAGE = "zh";

    /*玖戈用户默认密码*/
    public static final String JG_DEFAULT_PASSWORD = "jg";

    /*往来单位类型*/
    public interface RELATED_COMPY_TYPE {
        public static final String DR = "DR"; // 自有司机
        public static final String ADR = "ADR"; // 挂靠司机
        public static final String PDR = "PDR"; // 同行司机
        public static final String P = "P"; // 同行
    }

    /*用户类型*/
    public interface USER_TYPE {
        public static final String EMPLOYEE = "010"; // 员工
        public static final String DRIVER = "020"; // 司机
    }

    /*司机类型*/
    public interface DRIVER_TYPE {
        public static final String OWN = "0"; // 自有
        public static final String ATTACH = "1"; // 挂靠
        public static final String OUT = "2"; // 同行
    }

    /*运力类型*/
    public interface TRAILER_BELONG_TYPE {
        public static final String OWN = "0"; // 自有
        public static final String ATTACH = "1"; // 挂靠
        public static final String OUTER = "2"; // 同行
    }

    /*运输类型*/
    public interface TRANSPORT_TYPE {
        public static final String LONG = "1";
        public static final String SHORT = "2";
    }

    /*玖戈往来单位编码*/
    public static final String JG_COMPY_CODE = "OG000000";
    /*小杨啤酒往来单位编码*/
    public static final String XYPJ_COMPY_CODE = "OG000046";
    /*杨小姐往来单位编码（抽成费）*/
    public static final String YANG_COMPY_CODE = "JGOG000165";

    public interface OIL_PRICE_TYPE{
        public final static String SELF_PRICE = "1"; //自有司机结算油价
        public final static String PREDICTIVE_PRICE = "2"; //预提油价
        public final static String OUT_PRICE = "3"; //外排挂靠司机结算油价
        public final static String JG_PRICE = "4"; //玖戈车结算油价
    }

    /**
     * 油价审核状态
     */
    public interface OIL_APPROVAL_STATUS {
        public static final int UN_AUDIT = 1;//未审核
        public static final int AUDITED = 2;//已审核
        public static final int NO_NEED_APPROAL = 3;//无需审核
    }

    //行程标志
    public static final String  TRIP_FLAG_UP ="1";//上行
    public static final String  TRIP_FLAG_DOWN ="2";//下行

    public static final String  NONE ="0";//无
}
