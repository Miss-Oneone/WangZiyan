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
@Table(name = "mst_truck_frame")
public class TruckFrame extends IdEntity<TruckFrame> {

    @Column(name = "frame_card_id")
    private String frameCardId;

    @Column(name = "serial_no")
    private String serialNo;

    @Column(name = "frame_num")
    private String frameNum;

    @Column(name = "plate_num")
    private String plateNum;

    @Column(name = "status")
    private String status;

    @Column(name = "address")
    private String address;

    @Column(name = "current_contn_no")
    private String currentContnNo;

    @Column(name = "frame_type_id")
    private String frameTypeId;
}
