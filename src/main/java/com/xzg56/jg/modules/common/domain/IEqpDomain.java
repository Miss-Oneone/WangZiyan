package com.xzg56.jg.modules.common.domain;

import com.xzg56.jg.modules.common.persistence.entity.Contn;
import com.xzg56.jg.modules.common.persistence.entity.TruckFrame;

/**
 * Created by wellen on 2019/4/3.
 */
public interface IEqpDomain {
    void registerTruckFrame(TruckFrame truckFrame);

    void modifyTruckFrame(TruckFrame truckFrame);

    void deleteTruckFrame(int id);

    void registerContn(Contn contn);

    void modifyContn(Contn contn);

    void deleteContn(int id);

    void updateAddress(String mstType, String key, String address, String currBindContnNo, boolean recordHisFlag);

    void frameBindContn(int frameId, String contnNo);
}
