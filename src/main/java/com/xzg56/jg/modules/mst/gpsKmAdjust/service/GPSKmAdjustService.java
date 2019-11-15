package com.xzg56.jg.modules.mst.gpsKmAdjust.service;

import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.jg.modules.mst.gpsKmAdjust.dao.GPSKmAdjustDao;
import com.xzg56.jg.modules.mst.gpsKmAdjust.model.GPSKmAdjustModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wzr on 2019/6/10.
 */
@Service
public class GPSKmAdjustService extends BaseService {

    @Resource
    private GPSKmAdjustDao gpsKmAdjustDao;

    public List<GPSKmAdjustModel> search(GPSKmAdjustModel gpsKmAdjustModel) {
        List<GPSKmAdjustModel> gpsKmAdjustModelList = gpsKmAdjustDao.search(gpsKmAdjustModel);
        return gpsKmAdjustModelList;
    }

   @Transactional(readOnly = false)
    public void save(GPSKmAdjustModel gpsKmAdjustModel) {
       String userId = UserUtils.getUserId();
       if (gpsKmAdjustModel.getId() == 0) {
           //新增
           gpsKmAdjustModel.setCreateBy(userId);
           gpsKmAdjustDao.insertGPSKmAdjust(gpsKmAdjustModel);
       } else {
           //修改
           gpsKmAdjustModel.setUpdateBy(userId);
           gpsKmAdjustDao.updateGPSKmAdjust(gpsKmAdjustModel);
       }
    }
}
