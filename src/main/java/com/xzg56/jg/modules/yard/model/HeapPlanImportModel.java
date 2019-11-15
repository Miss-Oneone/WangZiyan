package com.xzg56.jg.modules.yard.model;

import com.xzg56.core.persistence.BaseModel;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportDtl;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wellen on 2019/9/3.
 */

@Getter
@Setter
public class HeapPlanImportModel extends BaseModel {
    private String goodsNo;
    private String goodsOweQuantity;
    private String customsClearanceDate;
    private List<HeapPlanImportDtl> dtls = new ArrayList<>();
}
