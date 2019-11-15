package com.xzg56.jg.modules.extrawork.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wzr on 2019/10/22.
 */
@Getter
@Setter
public class ExtraWorkModel extends IdEntity<ExtraWorkModel> {

    private static final long serialVersionUID = 1L;

    private String occurDate;
    private String driverCode;
    private String driverName;
    private String extraWorkId;
    private String extraWorkName;
    private String quantity = "1";
    private String amount="0";
    private String extraWorkAddKm;
    private String extraWorkOilPatch="0";
    private String addKm="0";
    private String addKmOilPatch="0";
    private String plateNum;
    private String frameId;
    private String frameCardId;
    private String frameNum;
    private String contnNo;
    private String orderNo;
    private String systemAutoFlag="N";
    private String deleteFlag="N";
    private String remarks;
    private String liters;
    private String extraWorkAmount;
    private String extraWorkOilPatchEach;//用于记录小活价目表中一笔小活的油补，方便页面计算
    private String amountSum;
    private String extraWorkOilPatchSum;
    private String addKmSum;
    private String addKmOilPatchSum;
}
