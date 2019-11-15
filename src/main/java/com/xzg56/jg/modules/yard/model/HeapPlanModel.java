package com.xzg56.jg.modules.yard.model;

import com.xzg56.core.persistence.BaseModel;
import com.xzg56.utility.StringUtils;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wellen on 2019/8/27.
 */

@Getter
@Setter
public class HeapPlanModel extends BaseModel {
    private int id;
    private int heapPlanImportHdId;
    private String contnNo;
    private String sealNo;
    private String reportSts;
    private String position;
    private String storageNo;
    private int quantity;
    private String plateLoading;
    private String unloadingDate;
    private String status;
    private String createBy;
    private String createTime;
    private String batchNo;
    private String goodsNo;
    private int goodsOweQuantity;
    private String customsClearanceDate;
    private String planDate;
    private String hasSameContn;
    private int cntUntreated;
    private int cntProcessed;
    private String cntNeedMoveContn;
    private String sameHeapContnNos;
    private int cntSameHeapContnNos;
    private String mainSameHeapContnNos;
    private String heapNo;
    private int actSize;
    private String colFloor;
    private List<HeapPlanModel> heapPlanModels = new ArrayList<>();

    public String getColFloor() {
        if (StringUtils.isNotBlank(position)) {
            String[] arr = StringUtils.split(position, "-");
            colFloor = StringUtils.toInteger(arr[1]) + "排" + StringUtils.toInteger(arr[2]);
        }
        return colFloor;
    }
}
