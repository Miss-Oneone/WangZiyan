package com.xzg56.finance.directcostmanage.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.finance.directcostmanage.model.DirectCostJgModel;

import java.util.List;

/**
 * Created by wjn on 2019/3/26.
 */
@SuppressWarnings("rawtypes")
@MyBatisDao
public interface DirectCostJgDao extends BaseDao<DirectCostJgModel> {

    public List<DirectCostJgModel> getDirectCostList(DirectCostJgModel directCostModel);

    List<DirectCostJgModel> getAmount(DirectCostJgModel directCostModel);
}
