package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/8/26.
 */

@Getter
@Setter
@Table(name = "heap_plan_import_hd")
public class HeapPlanImportHd extends IdEntity<HeapPlanImportHd> {

    @Column(name = "batch_no")
    private String batchNo;

    @Column(name = "goods_no")
    private String goodsNo;

    @Column(name = "goods_owe_quantity")
    private int goodsOweQuantity;

    @Column(name = "customs_clearance_date")
    private String customsClearanceDate;

    @Column(name = "status")
    private String status;
}
