package com.xzg56.jg.modules.helper.service;


import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.helper.dao.HelperDao;
import com.xzg56.jg.modules.helper.model.HelperModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wellen on 2019/4/26.
 */

@Transactional(readOnly = true)
@Service
public class HelperService extends BaseService {

    @Resource
    private HelperDao helperDao;

    public List<HelperModel> listChildStdAddress(String code) {
        return helperDao.listChildStdAddress(code);
    }
}
