package com.xzg56.jg.modules.api.gps.model;

import com.xzg56.core.persistence.BaseModel;

/**
 * Created on 2018/3/16.
 */
public class DzkaResultModel extends BaseModel {
    private String msg;
    private int code;
    private String data;

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
