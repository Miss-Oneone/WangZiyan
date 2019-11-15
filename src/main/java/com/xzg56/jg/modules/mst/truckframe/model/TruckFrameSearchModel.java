package com.xzg56.jg.modules.mst.truckframe.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/3.
 */

@Getter
@Setter
public class TruckFrameSearchModel extends IdEntity<TruckFrameSearchModel> {

    private String frameCardId;
    private String frameNum;
}
