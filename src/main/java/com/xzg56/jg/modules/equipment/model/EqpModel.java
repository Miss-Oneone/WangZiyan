package com.xzg56.jg.modules.equipment.model;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/8.
 */

@Getter
@Setter
public class EqpModel extends BaseModel{
    private int id;
    private String contnNo;
    private String contnType;
    private String activeFlag;
    private String address;
    private int count;
    private String plateNum;
    private String frameNum;
    private String frameCardNo;
    private String currBindContnNo;
}
