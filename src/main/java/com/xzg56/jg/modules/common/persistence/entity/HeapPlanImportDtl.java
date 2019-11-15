package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by wellen on 2019/8/26.
 */

@Getter
@Setter
@Table(name = "heap_plan_import_dtl")
public class HeapPlanImportDtl extends IdEntity<HeapPlanImportDtl> {

    @Column(name = "heap_plan_import_hd_id")
    private int heapPlanImportHdId;

    @Column(name = "contn_no")
    private String contnNo;

    @Column(name = "seal_no")
    private String sealNo;

    @Column(name = "report_sts")
    private String reportSts;

    @Column(name = "position")
    private String position;

    @Column(name = "storage_no")
    private String storageNo;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "plate_loading")
    private String plateLoading;

    @Column(name = "unloading_date")
    private Date unloadingDate;
}
