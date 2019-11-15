package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/4/3.
 */

@Getter
@Setter
@Table(name = "mst_contn")
public class Contn extends IdEntity<Contn> {

    @Column(name = "contn_no")
    private String contnNo;

    @Column(name = "contn_type")
    private String contnType;

    @Column(name = "SPECIAL_CONTN_TYPE")
    private String specialContnType;

    @Column(name = "address")
    private String address;

    @Column(name = "active_flag")
    private String activeFlag;

    @Column(name = "contn_onwer_id")
    private String contnOnwerId;

    @Column(name = "REMARKS")
    private String remarks;
}
