package com.xzg56.finance.feebatchmanage.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.finance.feebatchmanage.model.FeeBatchManageModel;
import com.xzg56.finance.feebatchmanage.model.FeeBatchManageSearchModel;
import com.xzg56.jg.modules.finance.expense.model.BatchAddPiModel;

import java.util.List;

/**
 *
 * @author wjn
 * @date 2019/1/3
 */
@SuppressWarnings("rawtypes")
@MyBatisDao
public interface FeeBatchManageDao extends BaseDao {

    List<FeeBatchManageModel> findFeeBatchManageList(FeeBatchManageSearchModel feeBatchManageSearchModel);

    List<BatchAddPiModel> searchList(BatchAddPiModel batchAddPiModel);
}
