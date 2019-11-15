package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.BaseModel;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by wellen on 2019/4/19.
 */

@Table(name = "fuel_filling_id_link")
@Getter
@Setter
public class FuelFillingIdLink extends BaseModel{

    @Id
    private int id;
    @Column(name = "fuel_filling_zg_id")
    private int fuelFillingZgId;
    @Column(name = "fuel_filling_jg_id")
    private int fuelFillingJgId;
}
