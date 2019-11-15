package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/4/28.
 */

@Getter
@Setter
@Table(name = "ord_route_info_contact")
public class OrdRouteInfoContact extends IdEntity<OrdRouteInfoContact> {
    @Column(name = "ord_route_info_id")
    private long ordRouteId;

    @Column(name = "name")
    private String name;

    @Column(name = "phone")
    private String phone;

    @Column(name = "sequence")
    private int sequence;
}
