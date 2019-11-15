package com.xzg56.jg.modules.mst.costroute.service;


import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.jg.modules.common.domain.IExpenseDomain;
import com.xzg56.jg.modules.common.persistence.dao.CostRouteDao;
import com.xzg56.jg.modules.common.persistence.entity.CostRoute;
import com.xzg56.jg.modules.mst.costroute.dao.CostRouteManDao;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteModel;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteSearchModel;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wellen on 2019/5/30.
 */

@Service
@Transactional(readOnly = true)
public class CostRouteSerivce extends BaseService {

    @Resource
    private CostRouteManDao costRouteManDao;

    @Resource
    private CostRouteDao costRouteDao;

    @Resource
    private IExpenseDomain expenseDomain;

    public List<CostRouteModel> listCostRoutes(CostRouteSearchModel searchModel) {
        List<CostRouteModel> costRouteModels = costRouteManDao.listCostRoutes(searchModel);
        List<Dict> trailerBelongTypes = DictUtils.getDictList(BizFcConstants.GROUP_NO.TRAILER_BELONG_TYPE);

        for (CostRouteModel costRouteModel : costRouteModels) {
            for (Dict trailerBelongType : trailerBelongTypes) {
                if (StringUtils.equals(costRouteModel.getTrailerBelongType(), trailerBelongType.getValue())) {
                    costRouteModel.setTrailerBelongType(trailerBelongType.getLabel());
                    break;
                }
            }
        }

        return costRouteModels;
    }

    public CostRouteModel findCostRouteById(String id) {
        return costRouteManDao.findById(id);
    }

    @Transactional(readOnly = false)
    public void doSave(CostRouteModel costRouteModel) {
//        checkMult(costRouteModel);
        CostRoute costRoute = new CostRoute();
        transformCostRoute(costRouteModel, costRoute);

        expenseDomain.registerCostRoute(costRoute);
    }

    @Transactional(readOnly = false)
    public void doUpdate(CostRouteModel costRouteModel) {
//        checkMult(costRouteModel);
        CostRoute costRoute = costRouteDao.get(StringUtils.toLong(costRouteModel.getId()));
        if (costRoute == null) {
            throw new ValidationException("当前成本路线不存在或已被删除.");
        }
        transformCostRoute(costRouteModel, costRoute);

        expenseDomain.updateCostRoute(costRoute);
    }

    @Transactional(readOnly = false)
    public void delete(CostRouteModel costRouteModel) {

    }

    /**
     *  校验当前路线是否已存在
     * @param costRouteModel
     */
    private void checkMult(CostRouteModel costRouteModel) {
        int cnt = costRouteManDao.countByAdrs(costRouteModel);
        if (cnt > 0) {
            throw new ValidationException("当前路线已存在，请勿重复添加");
        }
    }

    private void transformCostRoute(CostRouteModel costRouteModel, CostRoute costRoute) {
        costRoute.setFromProvinceCode(costRouteModel.getFromProvinceCode());
        costRoute.setFromCityCode(costRouteModel.getFromCityCode());
        costRoute.setFromDistrictCode(costRouteModel.getFromDistrictCode());
        costRoute.setFromCountyCode(costRouteModel.getFromCountyCode());
        costRoute.setToProvinceCode(costRouteModel.getToProvinceCode());
        costRoute.setToCityCode(costRouteModel.getToCityCode());
        costRoute.setToDistrictCode(costRouteModel.getToDistrictCode());
        costRoute.setToCountyCode(costRouteModel.getToCountyCode());
        costRoute.setDistanceAdjKm(costRouteModel.getDistanceAdjKm());
        costRoute.setStdDrvSalPrice(costRouteModel.getStdDrvSalPrice());
        costRoute.setTrailerBelongType(costRouteModel.getTrailerBelongType());
        costRoute.setRemarks(costRouteModel.getRemarks());
    }
}
