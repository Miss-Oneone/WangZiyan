package com.xzg56.jg.modules.helper.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.helper.model.HelperModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/4/26.
 */

@MyBatisDao
public interface HelperDao {
    List<HelperModel> listChildStdAddress(@Param("pcode") String pcode);
}
