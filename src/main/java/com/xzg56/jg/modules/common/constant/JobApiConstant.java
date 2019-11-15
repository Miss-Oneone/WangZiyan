package com.xzg56.jg.modules.common.constant;

/**
 * Created by zxp on 2019/1/3.
 */

public class JobApiConstant {
    public static final String API_KEY = "com.xzg56.job";

    /**
     * 返回给运柜宝的值
     */
    public interface JOB_RETURN_CODE {
        public final static int SUCCESS = 0;//接受成功
        public final static int FAIL = -1;//接受失败
    }
}
