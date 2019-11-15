package com.xzg56.jg.modules.common.constant;


import com.xzg56.core.config.Global;

/**
 * Created by wellen on 2019/6/10.
 */

public class ApiConstant {
    /* GPS服务 */
    public static final String GPS_SERVICE_APIKEY = "com.xzg56.gps";
    public static final String GPS_URL = Global.getConfig("gps.host");
    public static final String GPS_COMPY_CODE = "020";
    public interface API_RESULT_STATUS {
        public static final String SUCCESS = "0";
        public static final String ERROR = "1";
    }
    public interface GPS_INTERFACE {
        public final static String ONE_CAR_G_T_T = GPS_URL + "/gps/findOneCarGpsTrailerTrackList";
        public final static String MANY_CAR_G_T_T = GPS_URL + "/gps/findManyCarGpsTrailerTrackList";
        public final static String ONE_CAR_G_D_K = GPS_URL + "/gps/findOneCarGpsDailyKmList";
        public final static String MANY_CAR_G_D_K = GPS_URL + "/gps/findManyCarGpsDailyKmList";
        public final static String ONE_CAR_G_D_K_SUM = GPS_URL + "/gps/findOneCarGpsDailyKmSumList";
        public final static String MANY_CAR_G_D_K_SUM = GPS_URL + "/gps/findManyCarGpsDailyKmSumList";
        public final static String INSERT_M_T = GPS_URL + "/gps/insertMstTrailer";
        public final static String DELETE_M_T = GPS_URL + "/gps/deleteMstTrailer";
    }
    public static final String SYSTEM_USER_NAME = "系统";

    public static final String JGZX_SERVICE_APIKEY = "com.xzg56.9ge";
    public static final String JGZX_HOST = Global.getConfig("jgzx.host");
    public interface JGZX_API {
        public final static String GET_HEAPS = JGZX_HOST + "/api/yard/getHeaps";
        public final static String GET_HEAP_CONTNS = JGZX_HOST + "/api/yard/getHeapContns";
        public final static String GET_HEAP_TREE_FORM_SPEC = JGZX_HOST + "/api/yard/getHeapTreeFormSpec";
        public final static String UPDATE_HEAP_CONTN = JGZX_HOST + "/api/yard/updateHeapContn";
        public final static String SEARCH_CONTNS = JGZX_HOST + "/api/yard/searchContns";
        public final static String GET_HEAP_NO_BY_CONTN_NO = JGZX_HOST + "/api/yard/getHeapNoByContnNo";
        public final static String GET_HEAP_TYPE_BY_HEAP_NO = JGZX_HOST + "/api/yard/getHeapTypeByHeapNo";
        public final static String CHANGE_HEAP_TYPE = JGZX_HOST + "/api/yard/changeHeapType";
        public final static String UPDATE_HEAP_CONTNS = JGZX_HOST + "/api/yard/updateHeapContns";
        public final static String GET_DICTS_BY_GROUP_NO = JGZX_HOST + "/api/helper/getDictsByGroupNo";
        public final static String COUNT_HEAP_CONTNS_BY_HEAP_TYPE = JGZX_HOST + "/api/yard/countHeapContnsByHeapType";
    }
}
