package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.ZxAddress;
import org.apache.ibatis.annotations.Param;

/**
 * Created by wellen on 2019/5/20.
 */

@MyBatisDao
public interface ZxAddressDao extends BaseDao<ZxAddress> {

    ZxAddress get(@Param("id") long id);
}
