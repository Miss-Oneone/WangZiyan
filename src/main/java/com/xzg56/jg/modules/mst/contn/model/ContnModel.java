package com.xzg56.jg.modules.mst.contn.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/3.
 */

@Getter
@Setter
public class ContnModel extends BaseModel {
    private int id;
    private String contnNo;
    private String contnType;
    private String activeFlag;
    private String createBy;
    private String createTime;
    private String updateBy;
    private String updateTime;
    private boolean disabledFlag;
    private String contnOwner;
    private String contnOwnerId;
    private String specialContnType;
    private String specialContnTypeName;
    private String remarks;
}
