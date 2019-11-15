package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.Contn;
import org.apache.ibatis.annotations.Param;

/**
 * Created by wellen on 2019/4/3.
 */
@MyBatisDao
public interface ContnDao extends BaseDao<Contn> {

    Contn get(@Param("id") int id);

    Contn getByContnNo(@Param("contnNo") String contnNo);
}
