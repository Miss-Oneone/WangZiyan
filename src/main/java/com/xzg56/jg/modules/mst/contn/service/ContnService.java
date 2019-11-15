package com.xzg56.jg.modules.mst.contn.service;

import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.domain.IEqpDomain;
import com.xzg56.jg.modules.common.persistence.dao.ContnDao;
import com.xzg56.jg.modules.common.persistence.entity.Contn;
import com.xzg56.jg.modules.mst.contn.dao.ContnManDao;
import com.xzg56.jg.modules.mst.contn.model.ContnModel;
import com.xzg56.jg.modules.mst.contn.model.ContnSearchModel;
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
public class ContnService extends BaseService {

    @Resource
    private ContnManDao contnManDao;

    @Resource
    private ContnDao contnDao;

    @Resource
    private IEqpDomain eqpDomain;

    public List<ContnModel> listContns(ContnSearchModel searchModel) {
        return contnManDao.listContns(searchModel);
    }

    public ContnModel findContnById(int id) {
        return contnManDao.findContnById(id);
    }

    @Transactional(readOnly = false)
    public void saveContn(ContnModel contnModel) {
        Contn contn = new Contn();
        contn.setContnNo(contnModel.getContnNo());
        contn.setContnType(contnModel.getContnType());
        contn.setSpecialContnType(contnModel.getSpecialContnType());
        contn.setActiveFlag(contnModel.getActiveFlag());
        if(StringUtils.isNotBlank(contnModel.getContnOwnerId())) {
            contn.setContnOnwerId(contnModel.getContnOwnerId());
        }
        contn.setRemarks(contnModel.getRemarks());
        eqpDomain.registerContn(contn);
    }

    @Transactional(readOnly = false)
    public void updateContn(ContnModel contnModel) {
        Contn contn = contnDao.get(contnModel.getId());
        contn.setContnNo(contnModel.getContnNo());
        contn.setContnType(contnModel.getContnType());
        contn.setSpecialContnType(contnModel.getSpecialContnType());
        contn.setActiveFlag(contnModel.getActiveFlag());
        if(StringUtils.isNotBlank(contnModel.getContnOwnerId())) {
            contn.setContnOnwerId(contnModel.getContnOwnerId());
        } else {
            contn.setContnOnwerId(null);
        }
        contn.setRemarks(contnModel.getRemarks());
        eqpDomain.modifyContn(contn);
    }
}
