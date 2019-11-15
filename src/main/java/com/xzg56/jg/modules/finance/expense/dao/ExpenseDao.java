package com.xzg56.jg.modules.finance.expense.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.finance.expense.model.BatchAddPiModel;
import com.xzg56.jg.modules.finance.expense.model.EmOrderModel;
import com.xzg56.jg.modules.finance.expense.model.EmRecPayModel;
import com.xzg56.jg.modules.finance.expense.model.EmSearchModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface ExpenseDao extends BaseDao {

	EmOrderModel findEmOrderInfo(EmSearchModel searchModel);
	List<EmRecPayModel> findEmRecPayList(EmSearchModel searchModel);
	Integer insertEmRecPay(EmRecPayModel recPay);
	Integer updateEmRecPay(EmRecPayModel recPay);
	List<BatchAddPiModel> searchRecPayList(EmRecPayModel emRecPayModel);
	String getPiNameByCode(@Param("piCode") String piCode);
}
