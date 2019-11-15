package com.xzg56.finance.common.persistence.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.finance.bill.model.BillExportDataJgModel;
import com.xzg56.finance.common.model.BillExportJgModel;

import java.util.List;

/**
 * Created by lai_hanzhang on 2017/4/24.
 */
@MyBatisDao
public interface BillHeaderJgDao extends BaseDao {

	List<BillExportDataJgModel> findFeeAccountList(BillExportJgModel billExportJgModel);

	List<BillExportDataJgModel> findExcelText();

}
