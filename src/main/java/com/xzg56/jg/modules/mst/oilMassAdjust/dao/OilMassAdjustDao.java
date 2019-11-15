package com.xzg56.jg.modules.mst.oilMassAdjust.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.oilMassAdjust.model.OilMassAdjustModel;

import java.util.List;

@MyBatisDao
public interface OilMassAdjustDao {
    //列表补油查询
    List<OilMassAdjustModel> getOilMassAdjustModels(OilMassAdjustModel model);
    //新增
    void addOilMassModel(OilMassAdjustModel model);
    //更新
    void updateOilMassModel(OilMassAdjustModel model);
}
