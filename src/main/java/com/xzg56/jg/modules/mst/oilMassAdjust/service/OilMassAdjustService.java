package com.xzg56.jg.modules.mst.oilMassAdjust.service;

import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.jg.modules.mst.oilMassAdjust.dao.OilMassAdjustDao;
import com.xzg56.jg.modules.mst.oilMassAdjust.model.OilMassAdjustModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Transactional(readOnly = true)
@Service
public class OilMassAdjustService extends BaseService {

    @Resource
    OilMassAdjustDao oilMassAdjustDao;

    //查询
    public List<OilMassAdjustModel> search(OilMassAdjustModel model) {
        return  oilMassAdjustDao.getOilMassAdjustModels(model);
    }

    //保存
    @Transactional(readOnly = false)
    public void save(OilMassAdjustModel model) {
        String userId = UserUtils.getUserId();
        if (model.getId() == 0) {
            //新增
            model.setCreateBy(userId);
            oilMassAdjustDao.addOilMassModel(model);
        } else {
            //修改
            model.setUpdateBy(userId);
            oilMassAdjustDao.updateOilMassModel(model);
        }
    }
}
