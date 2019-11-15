package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/5/16.
 */

@Getter
@Setter
@Table(name = "ord_expense_temporary")
public class OrdExpenseTemporary extends IdEntity<OrdExpenseTemporary> {

    @Column(name = "batch_id")
    private String batchId;
    @Column(name = "type")
    private String type;
    @Column(name = "status")
    private String status;
    @Column(name = "params")
    private String params;
    @Column(name = "count")
    private int count;
}
