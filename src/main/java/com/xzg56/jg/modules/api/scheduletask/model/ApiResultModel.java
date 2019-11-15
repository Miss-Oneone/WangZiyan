package com.xzg56.jg.modules.api.scheduletask.model;


import com.xzg56.core.persistence.BaseModel;
import com.xzg56.jg.modules.common.constant.JobApiConstant;

import java.util.List;

/**
 * 我们回传给运柜宝的接口消息
 * code : 0 成功
 * code : -1 失败
 * Created on 2018/4/19.
 */
public class ApiResultModel extends BaseModel {
    private int code = JobApiConstant.JOB_RETURN_CODE.SUCCESS;
    private String msg;
    private Object data;
    private List<Object> dataList;

    public ApiResultModel() {

    }

    public void error(String msg) {
        this.setCode(JobApiConstant.JOB_RETURN_CODE.FAIL);
        this.setMsg(msg);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public List<Object> getDataList() {
        return dataList;
    }

    public void setDataList(List<Object> dataList) {
        this.dataList = dataList;
    }
}
