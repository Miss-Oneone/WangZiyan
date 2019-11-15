package com.xzg56.jg.modules.mst.bankAccount.service;


import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.mst.bankAccount.dao.BankAccountDao;
import com.xzg56.jg.modules.mst.bankAccount.model.BankAccountModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("BankAccountService")
@Transactional(readOnly = true)
public class BankAccountService extends BaseService {

    @Resource
    private BankAccountDao bankAccountDao;

    public List<BankAccountModel> findBankAccountList() {
        List<BankAccountModel> list = bankAccountDao.findBankAccountList();
        return list;
    }
}
