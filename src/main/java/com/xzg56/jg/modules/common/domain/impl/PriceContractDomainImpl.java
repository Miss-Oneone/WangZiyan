package com.xzg56.jg.modules.common.domain.impl;


import com.xzg56.common.module.sys.basic.service.NumberingService;
import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.finance.common.model.PriceContractTransModel;
import com.xzg56.jg.modules.common.domain.IPriceContractDomain;
import com.xzg56.jg.modules.common.persistence.dao.PriceContractBfDao;
import com.xzg56.jg.modules.common.persistence.dao.PriceContractCusDao;
import com.xzg56.jg.modules.common.persistence.dao.PriceContractDao;
import com.xzg56.jg.modules.common.persistence.dao.ZxAddressDao;
import com.xzg56.jg.modules.common.persistence.entity.PriceContract;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractBf;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractCus;
import com.xzg56.jg.modules.common.persistence.entity.ZxAddress;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

@Component
public class PriceContractDomainImpl implements IPriceContractDomain {

    @Resource
    private PriceContractBfDao priceContractBfDao;

    @Resource
    private PriceContractDao priceContractDao;

    @Resource
    private PriceContractCusDao priceContractCusDao;

    @Resource
    private ZxAddressDao zxAddressDao;

    @Resource
    public NumberingService numberingService;

    @Override
    public void registerPriceContractBf(PriceContractBf priceContractBf) {
        if (StringUtils.isEmpty(priceContractBf.getOverweightPrice())) {
            priceContractBf.setOverweightPrice(null);
        }
        if (StringUtils.isEmpty(priceContractBf.getLimitWeight())) {
            priceContractBf.setLimitWeight(null);
        }
        priceContractBfDao.insert(priceContractBf);
    }

    @Override
    public void modifyPriceContractBf(PriceContractBf priceContractBf) {
        if (StringUtils.isEmpty(priceContractBf.getOverweightPrice())) {
            priceContractBf.setOverweightPrice(null);
        }
        if (StringUtils.isEmpty(priceContractBf.getLimitWeight())) {
            priceContractBf.setLimitWeight(null);
        }
        priceContractBfDao.update(priceContractBf);
    }

    @Override
    public void deleteContractBf(long id) {
        PriceContractBf priceContractBf = priceContractBfDao.get(id);
        priceContractBf.setValidFlag("N");
        priceContractBfDao.update(priceContractBf);
    }

    @Override
    public PriceContractBf getPriceContractBf(Long id) {
        return priceContractBfDao.get(id);
    }

    @Override
    public LinkedHashMap getOrdGroupInputListByCusCode() {
        LinkedHashMap map = new LinkedHashMap();

        List<PriceContractTransModel> result = new ArrayList<>();
//                priceContractDao.getOrdGroupInputListByCusCode();

        for (PriceContractTransModel model : result){
            map.put(model.getCusCode(),model.getOrdInputGroup());
        }

        return map;
    }

    @Override
    public LinkedHashMap getOrdGroupInputListByPriceContractNo() {
        LinkedHashMap map = new LinkedHashMap();

        List<PriceContractTransModel> result = new ArrayList<>();
//                priceContractDao.getOrdGroupInputListByPriceContractNo();

        for (PriceContractTransModel model : result){
            map.put(model.getPriceContractNo(),model.getOrdInputGroup());
        }

        return map;
    }

    @Override
    public String getPriceContractNoNum() {
        return numberingService.getNumber(NumberingService.NUMBER_CODE.PRICE_CONTRACT_NO_CODE, BizFcConstants.SPACE);
    }

    @Override
    public void registerPriceContract(PriceContract priceContract) {
        String priceContractNo = getPriceContractNoNum();
        priceContract.setCreateBy(UserUtils.getUserId());
        priceContract.setPriceContractNo(priceContractNo);
        priceContractDao.insertPriceContract(priceContract);
    }

    @Override
    public void modifyPriceContract(PriceContract priceContract) {
        priceContract.setUpdateBy(UserUtils.getUserId());
        priceContractDao.updatePriceContract(priceContract);
    }

    @Override
    public void delete(String priceContractNo) {
        priceContractCusDao.deletePriceContractCus(priceContractNo, BizFcConstants.SPACE);
        priceContractBfDao.deletePriceContractBf(priceContractNo);
        priceContractDao.deletePriceContract(priceContractNo);
    }

    @Override
    public void registerPriceContractCus(PriceContractCus priceContractCus) {
        priceContractCus.setCreateBy(UserUtils.getUserId());
        priceContractCusDao.insertPriceContractCus(priceContractCus);
    }

    @Override
    public void modifyPriceContractCus(PriceContractCus priceContractCus) {
        priceContractCus.setUpdateBy(UserUtils.getUserId());
        priceContractCusDao.updatePriceContractCus(priceContractCus);
    }

    @Override
    public void registerZxAddress(ZxAddress zxAddress) {
        zxAddressDao.insert(zxAddress);
    }

    @Override
    public void modifyZxAdress(ZxAddress zxAddress) {
        zxAddressDao.update(zxAddress);
    }

    @Override
    public void deleteZxAddress(long id) {
        ZxAddress zxAddress = zxAddressDao.get(id);
        if (zxAddress != null) {
            zxAddress.setDeletedFlag(GlobalConstants.YES);
            zxAddressDao.update(zxAddress);
        }
    }

    @Override
    public ZxAddressDao getZxAddressDao() {
        return zxAddressDao;
    }
}
