package com.xzg56.finance.binsApprovalOrd.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.finance.binsApprovalOrd.model.BinsApprovalOrd;
import com.xzg56.finance.binsApprovalOrd.model.BinsApprovalOrdJg;
import com.xzg56.finance.binsApprovalOrd.model.BinsApprovalOrdJgModel;

import java.util.List;

@MyBatisDao
public interface BinsApprovalOrdJgDao extends BaseDao<BinsApprovalOrd> {
	List<BinsApprovalOrdJgModel> find(BinsApprovalOrdJg binsApprovalOrd);
}
