package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/4/8.
 */

@Getter
@Setter
@Table(name = "eqp_address_his")
public class EqpAddressHis extends IdEntity<EqpAddressHis> {

    @Column(name = "order_no")
    private String orderNo;

    @Column(name = "plate_num")
    private String plateNum;

    @Column(name = "frame_card_no")
    private String frameCardNo;

    @Column(name = "frame_num")
    private String frameNum;

    @Column(name = "contn_no")
    private String contnNo;

    @Column(name = "address")
    private String address;
}
