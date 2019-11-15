package com.xzg56.jg.modules.equipment.service;

import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.domain.IEqpDomain;
import com.xzg56.jg.modules.equipment.dao.EqpDao;
import com.xzg56.jg.modules.equipment.model.EqpModel;
import com.xzg56.jg.modules.equipment.model.EqpSearchModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wellen on 2019/4/8.
 */

@Service
@Transactional(readOnly = true)
public class EqpService extends BaseService {

    @Resource
    private EqpDao eqpDao;

    @Resource
    private IEqpDomain eqpDomain;

    public List<EqpModel> listTrailers(EqpSearchModel searchModel) {
        List<EqpModel> trailers =  eqpDao.listTrailers(searchModel);
        int idx = 1;
        for (EqpModel trailer : trailers) {
            trailer.setId(idx);
            idx++;
        }
        return trailers;
    }

    public List<EqpModel> listTruckFrames(EqpSearchModel searchModel) {
        return eqpDao.listTruckFrames(searchModel);
    }

    public List<EqpModel> listContns(EqpSearchModel searchModel) {
        return eqpDao.listContns(searchModel);
    }

    @Transactional(readOnly = false)
    public void updateAdrs(String mstType, String key, String address,String currBindContnNo) {
        eqpDomain.updateAddress(mstType, key, address,currBindContnNo, true);
    }
}
