package com.xzg56.jg.modules.extrawork.service;


import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.jg.modules.extrawork.dao.ExtraWorkDao;
import com.xzg56.jg.modules.extrawork.model.ExtraWorkModel;
import com.xzg56.jg.modules.extrawork.model.ExtraWorkSearchModel;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wzr on 2019/10/22.
 */
@Service
public class ExtraWorkService extends BaseService {

    @Resource
    private ExtraWorkDao extraWorkDao;

    @Transactional(readOnly = false)
    public List<ExtraWorkModel> getExtraWorkModelList(ExtraWorkSearchModel extraWorkSearchModel) {
        return extraWorkDao.getExtraWorkModelList(extraWorkSearchModel);
    }

    @Transactional(readOnly = false)
    public List<ExtraWorkModel> searchExtraWorkPriceItem() {
        return extraWorkDao.searchExtraWorkPriceItem();
    }

    @Transactional(readOnly = false)
    public ExtraWorkModel getExtraWorkById(ExtraWorkModel extraWorkModel) {
        return extraWorkDao.getExtraWorkById(extraWorkModel);
    }

    @Transactional(readOnly = false)
    public String searchPlateNumLiters(String plateNum) {
        return extraWorkDao.searchPlateNumLiters(plateNum);
    }

    @Transactional(readOnly = false)
    public ExtraWorkModel searchExtraWorkPrice(String id) {
        return extraWorkDao.searchExtraWorkPrice(id);
    }

    @Transactional(readOnly = false)
    public void addExtraWork(ExtraWorkModel extraWorkModel) {
        Long userId =  UserUtils.getUser().getId();
        extraWorkModel.setCreateBy(StringUtils.toString(userId));
        extraWorkDao.addExtraWork(extraWorkModel);
    }

    @Transactional(readOnly = false)
    public void eidtExtraWork(ExtraWorkModel extraWorkModel) {
        Long userId =  UserUtils.getUser().getId();
        extraWorkModel.setUpdateBy(StringUtils.toString(userId));
        extraWorkDao.eidtExtraWork(extraWorkModel);
    }

    @Transactional(readOnly = false)
    public void deleteExtraWork(ExtraWorkModel extraWorkModel) {
        Long userId =  UserUtils.getUser().getId();
        extraWorkModel.setUpdateBy(StringUtils.toString(userId));
        extraWorkDao.deleteExtraWork(extraWorkModel);
    }

    public ExtraWorkModel getAmount(ExtraWorkSearchModel extraWorkSearchModel) {
        return extraWorkDao.getAmount(extraWorkSearchModel);
    }
}
