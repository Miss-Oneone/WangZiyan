package com.xzg56.jg.modules.mst.contn.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.contn.model.ContnModel;
import com.xzg56.jg.modules.mst.contn.model.ContnSearchModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/4/3.
 */

@MyBatisDao
public interface ContnManDao {
    List<ContnModel> listContns(ContnSearchModel searchModel);

    ContnModel findContnById(@Param("id") int id);
}
