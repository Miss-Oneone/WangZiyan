package com.xzg56.jg.modules.equipment.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.equipment.model.EqpModel;
import com.xzg56.jg.modules.equipment.model.EqpSearchModel;

import java.util.List;

/**
 * Created by wellen on 2019/4/8.
 */

@MyBatisDao
public interface EqpDao {
    public List<EqpModel> listTrailers(EqpSearchModel searchModel);
    public List<EqpModel> listTruckFrames(EqpSearchModel searchModel);
    public List<EqpModel> listContns(EqpSearchModel searchModel);
}
