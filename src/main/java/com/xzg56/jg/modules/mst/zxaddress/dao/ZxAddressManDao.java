package com.xzg56.jg.modules.mst.zxaddress.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.zxaddress.model.ZxAddressModel;
import com.xzg56.jg.modules.mst.zxaddress.model.ZxAddressSearchModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface ZxAddressManDao {
    List<ZxAddressModel> getZxAddressList(ZxAddressSearchModel searchModel);
    ZxAddressModel getZxAddrsDetail(@Param("id") String id);
    ZxAddressModel getZxAddrsInfo(@Param("zxAddrsId") String zxAddrsId);
}
