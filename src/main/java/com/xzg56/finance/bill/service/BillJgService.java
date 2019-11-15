package com.xzg56.finance.bill.service;


import com.xzg56.core.service.BaseService;
import com.xzg56.finance.common.domain.IBillJgDomain;
import com.xzg56.finance.common.model.BillExportJgModel;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by zhouxuan on 2017/4/24.
 */
@Service
public class BillJgService extends BaseService {

    @Resource
    private IBillJgDomain iBillJgDomain;

    public HSSFWorkbook getExportFile(BillExportJgModel billExportJgData) {
        return iBillJgDomain.getExportFile(billExportJgData);

    }

}
