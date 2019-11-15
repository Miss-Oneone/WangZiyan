package com.xzg56.jg.modules.common.domain.impl;


import com.xzg56.core.exception.ValidationException;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.jg.modules.common.domain.IEqpDomain;
import com.xzg56.jg.modules.common.persistence.dao.ContnDao;
import com.xzg56.jg.modules.common.persistence.dao.EqpAddressHisDao;
import com.xzg56.jg.modules.common.persistence.dao.TrailerDao;
import com.xzg56.jg.modules.common.persistence.dao.TruckFrameDao;
import com.xzg56.jg.modules.common.persistence.entity.Contn;
import com.xzg56.jg.modules.common.persistence.entity.EqpAddressHis;
import com.xzg56.jg.modules.common.persistence.entity.Trailer;
import com.xzg56.jg.modules.common.persistence.entity.TruckFrame;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * Created by wellen on 2019/4/3.
 */

@Component
public class EqpDomain implements IEqpDomain {

    @Resource
    private TruckFrameDao truckFrameDao;

    @Resource
    private ContnDao contnDao;

    @Resource
    private TrailerDao trailerDao;

    @Resource
    private EqpAddressHisDao eqpAddressHisDao;

    @Override
    public void registerTruckFrame(TruckFrame truckFrame) {
        truckFrameDao.insert(truckFrame);
    }

    @Override
    public void modifyTruckFrame(TruckFrame truckFrame) {
        truckFrameDao.update(truckFrame);
    }

    @Override
    public void deleteTruckFrame(int id) {
        TruckFrame truckFrame = truckFrameDao.get(id);
        if (truckFrame == null) {
            throw new ValidationException("当前车架不存在或已被删除");
        }
        truckFrameDao.delete(truckFrame);
    }

    @Override
    public void registerContn(Contn contn) {
        Contn oldContn = contnDao.getByContnNo(contn.getContnNo());
        if (oldContn != null) {
            throw new ValidationException("当前箱号已存在，请勿重复添加");
        }
        contnDao.insert(contn);
    }

    @Override
    public void modifyContn(Contn contn) {
        Contn oldContn = contnDao.getByContnNo(contn.getContnNo());
        if (oldContn != null && !oldContn.getId().equals(contn.getId())) {
            throw new ValidationException("当前箱号已存在，请勿重复添加");
        }
        contnDao.update(contn);
    }

    @Override
    public void deleteContn(int id) {
        Contn contn = contnDao.get(id);
        if (contn == null) {
            throw new ValidationException("当前集装箱不存在或已被删除");
        }
        contnDao.delete(contn);
    }

    @Override
    public void updateAddress(String mstType, String key, String address,String currBindContnNo, boolean recordHisFlag) {
        if (StringUtils.equals(mstType, Constants.ADRS_MODIFY_TABLE_TYPE.TRAILER)) {
            Trailer trailer = trailerDao.get(key);
            if (trailer == null) {
                throw new ValidationException("当前车辆不存在或已被删除");
            }
            trailer.setAddress(address);
            trailerDao.update(trailer);

            if (recordHisFlag) {
                EqpAddressHis addressHis = new EqpAddressHis();
                addressHis.setPlateNum(key);
                addressHis.setAddress(address);
                eqpAddressHisDao.insert(addressHis);
            }

        } else if (StringUtils.equals(mstType, Constants.ADRS_MODIFY_TABLE_TYPE.TRUCK_FRAME)) {
            TruckFrame truckFrame = truckFrameDao.get(StringUtils.toInteger(key));
            if (truckFrame == null) {
                throw new ValidationException("当前车架不存在或已被删除");
            }
            truckFrame.setAddress(address==null?truckFrame.getAddress():address);
            truckFrame.setCurrentContnNo(currBindContnNo==null?truckFrame.getCurrentContnNo():currBindContnNo);
            truckFrameDao.update(truckFrame);

            if (recordHisFlag) {
                EqpAddressHis addressHis = new EqpAddressHis();
                addressHis.setFrameCardNo(truckFrame.getFrameCardId());
                addressHis.setFrameNum(truckFrame.getFrameNum());
                addressHis.setAddress(address);
                addressHis.setContnNo(currBindContnNo);
                eqpAddressHisDao.insert(addressHis);
            }

        } else if (StringUtils.equals(mstType, Constants.ADRS_MODIFY_TABLE_TYPE.CONTN)) {
            Contn contn = contnDao.get(StringUtils.toInteger(key));
            if (contn == null) {
                throw new ValidationException("当前自备箱不存在或已被删除");
            }
            contn.setAddress(address);
            contnDao.update(contn);

            if (recordHisFlag) {
                EqpAddressHis addressHis = new EqpAddressHis();
                addressHis.setContnNo(contn.getContnNo());
                addressHis.setAddress(address);
                eqpAddressHisDao.insert(addressHis);
            }
        }
    }

    @Override
    public void frameBindContn(int frameId, String contnNo) {
        TruckFrame truckFrame = truckFrameDao.get(frameId);
        if (truckFrame == null) {
            throw new ValidationException("当前车架不存在或已被删除");
        }
        truckFrame.setCurrentContnNo(contnNo);

        truckFrameDao.update(truckFrame);
    }
}
