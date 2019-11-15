package com.xzg56.jg.modules.mst.truckframe.service;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.jg.modules.common.domain.IEqpDomain;
import com.xzg56.jg.modules.common.persistence.dao.TruckFrameDao;
import com.xzg56.jg.modules.common.persistence.entity.TruckFrame;
import com.xzg56.jg.modules.mst.truckframe.dao.TruckFrameManDao;
import com.xzg56.jg.modules.mst.truckframe.model.TruckFrameModel;
import com.xzg56.jg.modules.mst.truckframe.model.TruckFrameSearchModel;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wellen on 2019/4/3.
 */

@Service
@Transactional(readOnly = true)
public class TruckFrameService extends BaseService {

    @Resource
    private TruckFrameManDao truckFrameManDao;

    @Resource
    private TruckFrameDao truckFrameDao;

    @Resource
    private IEqpDomain eqpDomain;

    public List<TruckFrameModel> listTruckFrames(TruckFrameSearchModel searchModel) {
        return truckFrameManDao.listTruckFrames(searchModel);
    }

    public TruckFrameModel findTruckFrameById(int truckFrameId) {
        return truckFrameManDao.findTruckFrameById(truckFrameId);
    }

    @Transactional(readOnly = false)
    public void saveTruckFrame(TruckFrameModel truckFrameModel) {
        TruckFrame truckFrame = new TruckFrame();
        truckFrame.setFrameCardId(truckFrameModel.getFrameCardId());
        truckFrame.setSerialNo(truckFrameModel.getSerialNo());
        truckFrame.setFrameNum(truckFrameModel.getFrameNum());
        truckFrame.setPlateNum(truckFrameModel.getPlateNum());
        truckFrame.setStatus(StringUtils.isBlank(truckFrameModel.getStatus()) ? Constants.TRUCK_FRAME_STATUS_CODE.INUSE : truckFrameModel.getStatus());
        truckFrame.setFrameTypeId(truckFrameModel.getFrameTypeId());

        eqpDomain.registerTruckFrame(truckFrame);
    }

    @Transactional(readOnly = false)
    public void updateTruckFrame(TruckFrameModel truckFrameModel) {
        TruckFrame truckFrame = truckFrameDao.get(truckFrameModel.getId());
        if (truckFrame == null) {
            throw new ValidationException("当前车架不存在");
        }
        truckFrame.setFrameCardId(truckFrameModel.getFrameCardId());
        truckFrame.setSerialNo(truckFrameModel.getSerialNo());
        truckFrame.setFrameNum(truckFrameModel.getFrameNum());
        truckFrame.setPlateNum(truckFrameModel.getPlateNum());
        truckFrame.setStatus(StringUtils.isBlank(truckFrameModel.getStatus()) ? Constants.TRUCK_FRAME_STATUS_CODE.INUSE : truckFrameModel.getStatus());
        truckFrame.setFrameTypeId(truckFrameModel.getFrameTypeId());

        eqpDomain.modifyTruckFrame(truckFrame);
    }

    @Transactional(readOnly = false)
    public void deleteTruckFrame(int id) {
        eqpDomain.deleteTruckFrame(id);
    }
}
