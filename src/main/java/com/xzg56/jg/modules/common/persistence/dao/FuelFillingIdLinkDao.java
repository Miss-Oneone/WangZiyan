package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.common.persistence.entity.FuelFillingIdLink;
import org.apache.ibatis.annotations.Param;

/**
 * Created by wellen on 2019/4/19.
 */
@MyBatisDao
public interface FuelFillingIdLinkDao {
    FuelFillingIdLink get(@Param("id") int id);
    FuelFillingIdLink getByZgId(@Param("zgId") int zgId);
    void insert(FuelFillingIdLink idLink);
}
