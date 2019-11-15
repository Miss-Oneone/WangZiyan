package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractCus;
import org.apache.ibatis.annotations.Param;

@MyBatisDao
public interface PriceContractCusDao extends BaseDao {
    PriceContractCus get(@Param("priceContractNo") String priceContractNo);

    void insertPriceContractCus(PriceContractCus priceContractCus);

    void updatePriceContractCus(PriceContractCus priceContractCus);

    void deletePriceContractCus(@Param("priceContractNo") String priceContractNo, @Param("cusCode") String cusCode);
}
