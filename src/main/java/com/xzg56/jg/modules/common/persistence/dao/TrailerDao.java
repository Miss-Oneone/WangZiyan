package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.common.persistence.entity.Trailer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wellen on 2019/4/8.
 */

@MyBatisDao
public interface TrailerDao {
    Trailer get(@Param("plateNum") String plateNum);

    void insert(Trailer trailer);

    void update(Trailer trailer);

    List<String> listPlateNums();
}
