package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.OrdExpenseTemporary;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/5/16.
 */

@MyBatisDao
public interface OrdExpenseTemporaryDao extends BaseDao<OrdExpenseTemporary> {

    OrdExpenseTemporary get(@Param("id") long id);

    List<OrdExpenseTemporary> listForBatch();
}
