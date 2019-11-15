package com.xzg56.jg.modules.mst.bankAccount.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.mst.bankAccount.model.BankAccountModel;

import java.util.List;

@MyBatisDao
public interface BankAccountDao extends BaseDao<BankAccountModel> {
    List<BankAccountModel> findBankAccountList();
}
