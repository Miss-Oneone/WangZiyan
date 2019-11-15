package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.PriceContract;
import org.apache.ibatis.annotations.Param;

@MyBatisDao
public interface PriceContractDao extends BaseDao {
    PriceContract get(@Param("priceContractNo") String priceContractNo);

    void insertPriceContract(PriceContract priceContract);

    void updatePriceContract(PriceContract priceContract);

    void deletePriceContract(@Param("priceContractNo") String priceContractNo);
}
